# -*- coding: utf-8 -*-
#IMPORTS DJANGO
from django.shortcuts import render, get_object_or_404, redirect
from django.http import HttpResponse, JsonResponse
from django.contrib.auth.decorators import login_required
from django.core import serializers
from django.contrib.auth.models import User
from django.views.decorators.csrf import csrf_exempt
#IMPORTS PLATAFORMA
from .models import Proyecto, Dispositivo, Sensor,Campo
from .forms import FormProyecto,FormDispositivo,FormSensor,FormCampo
import json
from .models import EscalaDeValor, Rango  

@login_required(login_url = 'cuentas:login')
def index(request):
    usuario = User.objects.get(username=request.user)
    proyectos = Proyecto.objects.filter(usuario=request.user)
    numero_proyectos = proyectos.count()
    numero_dispositivos = 0
    numero_sensores = 0
    for pro in proyectos:
        for dis in pro.dispositivo_set.all():
            numero_dispositivos+=1
            for sen in dis.sensor_set.all():
                numero_sensores+=1

    context = {
        'proyectos': proyectos,
        'numero_proyectos':numero_proyectos,
        'numero_dispositivos':numero_dispositivos,
        'numero_sensores':numero_sensores,
        'usuario': usuario,
    }

    return render(request,'dashboard/index_n.html',context)


# ==================
#   VISTAS CORRESPONDIENTES A PROYECTOS
# ==================
# VISTA PARA CREAR UN PROYECTO
@login_required(login_url = 'cuentas:login')
def formularioProyecto(request):

    form = FormProyecto(request.POST or None)
    if form.is_valid():
        proyecto = form.save()
        proyecto.usuario = request.user
        form = FormProyecto()
        proyecto.save()

    usuario = User.objects.get(username=request.user)
    proyectos = Proyecto.objects.filter(usuario=request.user)

    numero_sensores = 0
    numero_dispositivos = 0
    lista_proyectos = []

    for pro in proyectos:
        for dis in pro.dispositivo_set.all():
            for sen in dis.sensor_set.all():
                numero_sensores+=1
            numero_dispositivos+=1
        
        lista_proyectos.append({
            'id': pro.id,
            'nombre': pro.nombre_de_proyecto,
            'descripcion': pro.descripcion,
            'dispositivos': numero_dispositivos,
            'sensores': numero_sensores
        })
        numero_sensores = 0
        numero_dispositivos = 0

    context = {
        'usuario': usuario,
        'form': form,
        'proyectos': lista_proyectos,
    }

    return render(request,'dashboard/proyectos_n.html',context)


@login_required(login_url = 'cuentas:login')
def modificarProyecto(request, id):

    proyecto = get_object_or_404(Proyecto, pk=id)
    form = FormProyecto(request.POST or None, instance=proyecto)
    

    if request.method == 'POST' and form.is_valid():
        form.save()
    
    return redirect( 'dashboard:detalle-proyecto',proyecto.id)


# VISTA ENCARGADA DE ELIMINAR UN PROYECTO
@login_required(login_url = 'cuentas:login')
def eliminarProyecto(request, id):
    proyecto = get_object_or_404(Proyecto, pk=id)
    try:
        proyecto.delete()
        return HttpResponse("Proyecto " + str(id) + " eliminado exitosamente")
    except:
        pass
    return HttpResponse("Proyecto " + str(id) + " NO eliminado exitosamente")

@login_required(login_url = 'cuentas:login')
def detalleProyecto(request, id_proyecto):
    proyecto = get_object_or_404(Proyecto, id=id_proyecto)
    dispositivos = proyecto.dispositivo_set.all()

    form = FormProyecto(instance=proyecto)
    formDisp = FormDispositivo( initial={'proyecto':str(proyecto.id)}, hide=['proyecto'],usuario=request.user)

    usuario = User.objects.get(username=request.user)
    contexto= {
        'form_modificar':form,
        'form': formDisp,
        'proyecto': proyecto,
        'dispositivos': dispositivos,
        'usuario': usuario
    }
    return render(request, 'dashboard/detalle-proyecto_n.html', contexto)


# ==================
#   VISTAS CORRESPONDIENTES A DISPOSITIVOS
# ==================
# VISTA QUE ENLISTA TODOS LOS DISPOSITIVOS
@login_required(login_url = 'cuentas:login')
def formularioDispositivo(request):
    form = FormDispositivo(request.POST or None,usuario=request.user)
    usuario = User.objects.get(username=request.user)

    if form.is_valid():
        dispositivo = form.save()
        form = FormDispositivo()

    #Obtenemos todos los proyectos, enseguida los dispositios pertenecientes a estos
    dispositivos = []
    proyectos = Proyecto.objects.filter(usuario=request.user)
    for pro in proyectos:
        dispositivos += pro.dispositivo_set.all()
    
    contexto = {
        'form': form,
        'dispositivos':dispositivos,
        'usuario': usuario,
    }

    return render(request,'dashboard/dispositivos_n.html',contexto)

# VISTA PARA CREAR UN DISPOSITIVO
@login_required(login_url = 'cuentas:login')
def crearDispositivo(request):

    form = FormDispositivo(request.POST or None)

    if form.is_valid():
        dispositivo = form.save()
        
    return redirect( 'dashboard:detalle-dispositivo',dispositivo.id)

@login_required(login_url = 'cuentas:login')
def detalleDispositivo(request, id_dispositivo):

    dispositivo = get_object_or_404(Dispositivo,id=id_dispositivo)

    lista_sensores = []
    lista_sensores = dispositivo.sensor_set.all()

    formulario_dispositivo = FormDispositivo(request.POST or None,usuario=request.user,instance=dispositivo)
    #form = FormDispositivo(request.POST or None,usuario=request.user)
    formulario_sensor = FormSensor(request.POST or None)

    contexto = {
        'dispositivo': dispositivo,
        'sensores': lista_sensores,
        'form': formulario_dispositivo,
        'formulario_sensor': formulario_sensor,
    }

    return render(request, 'dashboard/detalle-dispositivo_n.html', contexto)


# VISTA PARA LA MODIFICACIÓN DE DATOS DE ALGÚN DISPOSITIVO
@login_required(login_url = 'cuentas:login')
def modificarDispositivo(request, id):
    # Se obtiene el dispositivo
    dispositivo = get_object_or_404(Dispositivo, pk=id)
    # Se llena el formulario con los datos obtenidos y se relaciona 
    # a la instancia del dispositivo correspondiente
    form = FormDispositivo(request.POST or None, instance=dispositivo)
    
    # Si el formulario es válido
    if request.method == 'POST' and form.is_valid():
        form.save()
        return redirect( 'dashboard:detalle-dispositivo',dispositivo.id)

@login_required(login_url = 'cuentas:login')
def eliminarDispositivo(request, id):
    dispositivo = get_object_or_404(Dispositivo, pk=id)
    try:
        dispositivo.delete()
        return HttpResponse("Dispositivo " + str(id) + " eliminado exitosamente ")
    except:
        pass
    return HttpResponse("Dispositivo " + str(id) + " no eliminado " )

# ==================
#   VISTAS CORRESPONDIENTES A SENSORES
# ==================
@login_required(login_url = 'cuentas:login')
def formularioSensor(request,id_dispositivo):

    dispositivo = Dispositivo.objects.get(pk=id_dispositivo)
    contexto = {
        'dispositivo': dispositivo
    }
    
    return render(request, 'dashboard/form-sensor_n.html' , contexto)

@login_required(login_url = 'cuentas:login')
def crearSensor(request,id_dispositivo):
    
    #Obtenemos los datos del sensor
    nombre = request.GET.get("nombre_sensor","false")
    tipo = request.GET.get("tipo_sensor","false")
    habilitado = True if request.GET.get("habilitado_sensor","false") == 'on' else False


    #Obtenemos los datos de los campos del sensor
    nombres_campo = request.GET.get("nombres_campo","false")
    tipos_campo = request.GET.get("tipos_campo","false")


    #Obtenemos el dispositivo
    dispositivo = Dispositivo.objects.get(pk=id_dispositivo)

    #Creamos y guardamos en la base de datos el nuevo sensor
    nuevo_sensor = Sensor.objects.create(nombre_de_sensor=nombre,tipo=tipo,esta_habilitado=habilitado,dispositivo=dispositivo)
    nuevo_sensor.save()

    #Con el método split obtenemos una lista por cada serie de campos y tipos
    campos = nombres_campo.split(',')
    tipos = tipos_campo.split(',')


    print(campos)
    print(tipos)

    #Creamos y guardamos cada uno de los campos del sensor
    for i in range(0,len(campos)):
        nuevo_campo = Campo.objects.create(nombre_de_campo=campos[i],tipo_de_valor=tipos[i],sensor=nuevo_sensor)
        nuevo_campo.save()

    #Una vez terminada todas las operaciones redirijimos al dispositivo
    return redirect( 'dashboard:detalle-dispositivo',dispositivo.id)

@login_required(login_url = 'cuentas:login')
def eliminarSensor(request, id):
    sensor = get_object_or_404(Sensor,pk=id)
    try:
        sensor.delete()
        return HttpResponse("Sensor" + str(id) + "eliminado exitosamente ")
    except:
        pass
    return HttpResponse("Sensor" + str(id) + "no eliminado")

def obtenerCoordenadas(request, id_proyecto):
    proyecto = get_object_or_404(Proyecto, id=id_proyecto)

    dispositivos = proyecto.dispositivo_set.all()
    lista_de_datos = []
    for dispositivo in dispositivos:
        lista_de_datos.append([dispositivo.nombre_de_dispositivo,dispositivo.latitud, dispositivo.longitud ])

    datos={
        "dispositivos" : lista_de_datos
    }

    #return HttpResponse(json.dumps(lista_dispositivos), content_type='application/json')
    #return JsonResponse( datos )
    return HttpResponse(json.dumps(datos),content_type='application/json')
    


@login_required(login_url = 'cuentas:login')
def configuracion(request):

    usuario = request.user

    context = {'usuario': usuario}

    return render(request, 'dashboard/configuracion.html', context)


@login_required(login_url = 'cuentas:login')
@csrf_exempt
def redProyecto(request,id_proyecto):

    proyecto = Proyecto.objects.get(pk = id_proyecto)
    dispositivos = Dispositivo.objects.filter(proyecto=proyecto)

    lista_dispositivos = []
    
    for dispo in dispositivos:
        dict_aux = {'dispositivos': dispo.nombre_de_dispositivo,'sensores': 0 }
        lista_sensores = []

        for sensor in Sensor.objects.filter(dispositivo = dispo.pk):
            lista_sensores.append(sensor.nombre_de_sensor)
            
        dict_aux['sensores'] = lista_sensores
        lista_dispositivos.append(dict_aux)


    return HttpResponse(json.dumps(lista_dispositivos), content_type='application/json')


@csrf_exempt
def api_escala_de_valores(request):
    if request.method == "GET":
        escalas = EscalaDeValor.objects.all().values('id', 'nombre', 'descripcion')
        return JsonResponse(list(escalas), safe=False)

    elif request.method == "POST":
        try:
            data = json.loads(request.body.decode('utf-8'))
            escala = EscalaDeValor(nombre=data['nombre'], descripcion=data['descripcion'])
            escala.save()
            return JsonResponse({'status': 'ok', 'id': escala.id})
        except Exception as e:
            return JsonResponse({'status': 'error', 'mensaje': str(e)})

    elif request.method == "PUT":
        try:
            data = json.loads(request.body.decode('utf-8'))
            escala_id = data.get('id')
            escala = EscalaDeValor.objects.get(pk=escala_id)
            escala.nombre = data.get('nombre', escala.nombre)
            escala.descripcion = data.get('descripcion', escala.descripcion)
            escala.save()
            return JsonResponse({'status': 'ok'})
        except EscalaDeValor.DoesNotExist:
            return JsonResponse({'status': 'error', 'mensaje': 'Escala no encontrada'}, status=404)
        except Exception as e:
            return JsonResponse({'status': 'error', 'mensaje': str(e)})

    elif request.method == "DELETE":
        try:
            data = json.loads(request.body.decode('utf-8'))
            escala_id = data.get('id')
            escala = EscalaDeValor.objects.get(pk=escala_id)
            escala.delete()
            return JsonResponse({'status': 'ok'})
        except EscalaDeValor.DoesNotExist:
            return JsonResponse({'status': 'error', 'mensaje': 'Escala no encontrada'}, status=404)
        except Exception as e:
            return JsonResponse({'status': 'error', 'mensaje': str(e)})


@csrf_exempt
def api_rangos(request):
    if request.method == "GET":
        rangos = Rango.objects.all().values('id', 'nombre', 'valor_minimo', 'valor_maximo', 'color', 'escala_id')
        return JsonResponse(list(rangos), safe=False)

    elif request.method == "POST":
        try:
            data = json.loads(request.body.decode('utf-8'))
            escala_id = data['escala_id']
            escala = EscalaDeValor.objects.get(pk=escala_id)
            rango = Rango(
                nombre=data['nombre'],
                valor_minimo=data['valor_minimo'],
                valor_maximo=data['valor_maximo'],
                color=data['color'],
                escala=escala
            )
            rango.save()
            return JsonResponse({'status': 'ok', 'id': rango.id})
        except Exception as e:
            return JsonResponse({'status': 'error', 'mensaje': str(e)})

    elif request.method == "PUT":
        try:
            data = json.loads(request.body.decode('utf-8'))
            rango_id = data.get('id')
            rango = Rango.objects.get(pk=rango_id)
            rango.nombre = data.get('nombre', rango.nombre)
            rango.valor_minimo = data.get('valor_minimo', rango.valor_minimo)
            rango.valor_maximo = data.get('valor_maximo', rango.valor_maximo)
            rango.color = data.get('color', rango.color)
            
            escala_id = data.get('escala_id')
            if escala_id:
                escala = EscalaDeValor.objects.get(pk=escala_id)
                rango.escala = escala
            
            rango.save()
            return JsonResponse({'status': 'ok'})
        except Rango.DoesNotExist:
            return JsonResponse({'status': 'error', 'mensaje': 'Rango no encontrado'}, status=404)
        except Exception as e:
            return JsonResponse({'status': 'error', 'mensaje': str(e)})

    elif request.method == "DELETE":
        try:
            data = json.loads(request.body.decode('utf-8'))
            rango_id = data.get('id')
            rango = Rango.objects.get(pk=rango_id)
            rango.delete()
            return JsonResponse({'status': 'ok'})
        except Rango.DoesNotExist:
            return JsonResponse({'status': 'error', 'mensaje': 'Rango no encontrado'}, status=404)
        except Exception as e:
            return JsonResponse({'status': 'error', 'mensaje': str(e)})



@csrf_exempt
def api_rango_individual(request, rango_id):
    try:
        rango = Rango.objects.get(pk=rango_id)
    except Rango.DoesNotExist:
        return JsonResponse({'status': 'error', 'mensaje': 'Rango no encontrado'}, status=404)

    if request.method == 'GET':
        return JsonResponse({
            'id': rango.id,
            'nombre': rango.nombre,
            'valor_minimo': rango.valor_minimo,
            'valor_maximo': rango.valor_maximo,
            'color': rango.color,
            'escala': rango.escala.id
        })

    elif request.method == 'PUT':
        try:
            data = json.loads(request.body.decode('utf-8'))

            rango.nombre = data.get('nombre', rango.nombre)
            rango.valor_minimo = data.get('valor_minimo', rango.valor_minimo)
            rango.valor_maximo = data.get('valor_maximo', rango.valor_maximo)
            rango.color = data.get('color', rango.color)
            rango.save()

            return JsonResponse({'status': 'ok', 'mensaje': 'Rango actualizado'})
        except Exception as e:
            return JsonResponse({'status': 'error', 'mensaje': str(e)}, status=400)

    elif request.method == 'DELETE':
        rango.delete()
        return JsonResponse({'status': 'ok', 'mensaje': 'Rango eliminado'})

    else:
        return HttpResponseBadRequest("Método no soportado")
    
@csrf_exempt
def api_escala_individual(request, escalas_id):
    try:
        escala = EscalaDeValor.objects.get(pk=escalas_id)
    except EscalaDeValor.DoesNotExist:
        return JsonResponse({'status': 'error', 'mensaje': 'Escala de valor no encontrada'}, status=404)
    
    if request.method == 'GET':
        return JsonResponse({
            'id':escala.id,
            'nombre':escala.nombre,
            'descripcion':escala.descripcion
            
            })
    elif request.method == 'PUT':
        try:
            data = json.loads(request.body.decode('utf-8'))
            escala.nombre = data.get('nombre', escala.nombre)
            escala.descripcion = data.get('descripcion', escala.descripcion)
            escala.save()
            return JsonResponse({'status': 'ok', 'mensaje': 'Escala actualizada'})
        except Exception as e:
            return JsonResponse({'status': 'error', 'mensaje': 'No se pudo actualizar'})
                
    elif request.method == 'DELETE':
        escala.delete()
        return JsonResponse({'status': 'ok', 'mensaje': 'Escala eliminado'})
    else:
        return JsonRresponse({'status': 'error', 'mensaje': 'Metodo no permitidp'})
