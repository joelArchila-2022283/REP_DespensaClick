package com.joelarchila.DespensaClick.controller;

import com.joelarchila.DespensaClick.model.Empleado;
import com.joelarchila.DespensaClick.service.EmpleadoService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Objects;

//Avisa que esta clase manejará datos
@RestController

//Anotacion para ver que ruta va a llamar
@RequestMapping("/api/empleados")

public class EmpleadoController {
    private final EmpleadoService empleadoService;

    public EmpleadoController(EmpleadoService empleadoService){
        this.empleadoService=empleadoService;;

    }

    //Anotación que cuando se abre la ruta, le avisa al Service que devuelva la lista(Empleados)
    @GetMapping
    public List<Empleado> getAllEmpleados(){return empleadoService.getAllEmpleados();}

    //Anotación cuando envian datos nuevos, el controlador los recibe
    @PostMapping
    public ResponseEntity<Object> createEmpleado(@Valid @RequestBody Empleado empleado){
        try{
            Empleado createdEmpleado = empleadoService.saveEmpleado(empleado);
            return new ResponseEntity<>(createdEmpleado, HttpStatus.CREATED);
        }catch (IllegalArgumentException e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }

    }

    //Anotacion
    @PutMapping("/{id}")
    public ResponseEntity<Empleado> updateEmpleado(@PathVariable Integer id, @RequestBody Empleado empleado){
        //Le pasamos el id y los datos nuevos al service
        Empleado actualizado = empleadoService.updateEmpleado(id, empleado);

        if(actualizado != null){
            //Si el servicio nos devolvio al empleado porque exista, respodemos con el httpstatus
            return new ResponseEntity<>(actualizado, HttpStatus.OK);
        } else{
            //Si el servicio devolvio null, respondemos con httpstatus
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    //Anotacion para quitar algo del servidor
    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteEmpleado(@PathVariable Integer id){
        //Intenta buscar para saber si esta ahi el empleado
        Empleado empleado = empleadoService.getEmpleadoById(id);

        if(empleado != null){
            empleadoService.deleteEmpleado(id);
            return new ResponseEntity<>("El empleado ha sido eliminado con exito", HttpStatus.OK);

        }else{
            return new ResponseEntity<>("No se ha encontrado el empleado con ID: "+id, HttpStatus.NOT_FOUND);
        }
    }

}
