# -*- coding: utf-8 -*-
#importación del paquete models
from django.db import models
#importación de la clase User
from django.contrib.auth.models import User
from django.db.models import SET_NULL

#Declaración de clase Proyecto. Hereda de la clase Model
class Proyecto(models.Model):
    #Usuario dueño del proyecto
    usuario = models.ForeignKey(User, null=True, blank=True, default=1, on_delete=models.SET_NULL)
    #Identificador del proyecto
    nombre_de_proyecto = models.CharField( max_length = 80)
    #Descripción que el usuario puede dar a su dispositivo
    descripcion = models.TextField()
    #Método __str__ para indentificar mas facilmente el proyecto
    def __str__(self):
        return self.nombre_de_proyecto

#Declaración de clase Dispositivo. Hereda de la clase Model
class Dispositivo(models.Model):
    #Identificador del dispositivo
    nombre_de_dispositivo = models.CharField(max_length = 80)
    #Descripción que el usuario puede dar a su dispositivo
    descripcion = models.TextField()
    #Describir el tipo de dispositivo ejemplo: Acuatico, Terrestre etc
    tipo = models.CharField(max_length=40)
    #Latitud para ubicar geográficamente el dispositivo
    latitud = models.FloatField(blank=True, null=True)
    #Longitud para ubicar geográficamente el dispositivo
    longitud = models.FloatField(blank=True, null=True)
    #Variable booleana para identificar a actividad o inactividad de los dispositivos
    esta_habilitado = models.BooleanField(default = True)
    #Variable que guarda la fecha en la que se registró el dispositivo en el sistema
    fecha_creacion = models.DateTimeField( auto_now_add=True )
    #Llave foránea a Clase Proyecto 
    proyecto = models.ForeignKey(Proyecto, null=True, blank=True, default=1, on_delete=models.SET_NULL)
    #Método __str__ para indentificar mas facilmente el dispositivo
    def __str__(self):
        return self.nombre_de_dispositivo


class Sensor(models.Model):
    #Identificador del sensor
    nombre_de_sensor = models.CharField(max_length=40)
    #Tipo de sensor a emplear
    tipo = models.CharField(max_length = 40)
    #Variable que guarda la fecha en la que se registró el sensor en el sistema
    fecha_creacion = models.DateTimeField( auto_now_add=True )
    #Variable booleana para identificar a actividad o inactividad de los dispositivos
    esta_habilitado = models.BooleanField(default = True)
    #Llave foránea a Clase Dispositivo
    dispositivo = models.ForeignKey(Dispositivo, null=True, blank=True, default=1, on_delete=models.SET_NULL)
    #Método __str__ para indentificar mas facilmente el sensor
    def __str__(self):
        return self.nombre_de_sensor


class Campo( models.Model):
    nombre_de_campo = models.CharField(max_length=30)
    tipo_de_valor = models.CharField(max_length=40)
    sensor = models.ForeignKey(Sensor, null=True, blank=True, default=1, on_delete=models.SET_NULL)

    def __str__(self):
        return self.nombre_de_campo


class Valor(models.Model):
    valor = models.CharField(max_length=100)
    fecha_hora_lectura = models.DateTimeField(auto_now_add=True)
    fecha_dispositivo = models.DateTimeField(blank=True, null=True)
    id_paquete = models.IntegerField(default=0)
    campo = models.ForeignKey(Campo, null=True, blank=True, default=1, on_delete=models.SET_NULL)

    def __str__(self):
        return self.valor
    
class EscalaDeValor(models.Model):
    nombre = models.CharField(max_length=100)
    descripcion = models.TextField(blank=True)
    sensor = models.ForeignKey('Sensor', null=True, blank=True, on_delete=models.CASCADE,related_name='escalas')
    
    def __str__(self):
        return "{}({})".format(self.nombre, self.sensor)
    
    
class Rango(models.Model):
    escala = models.ForeignKey(EscalaDeValor, related_name='rangos', on_delete=models.CASCADE)
    nombre = models.CharField(max_length=100)
    descripcion = models.TextField(blank=True)
    valor_minimo = models.FloatField()
    valor_maximo = models.FloatField()
    color = models.CharField(max_length=20, blank= True, null=True)
    
    def __str__(self):
        return "{} ({} a {})".format(self.nombre, self.valor_minimo, self.valor_maximo)
        