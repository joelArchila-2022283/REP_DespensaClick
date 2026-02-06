package com.joelarchila.DespensaClick.service;


import com.joelarchila.DespensaClick.model.Empleado;
import com.joelarchila.DespensaClick.repository.EmpleadoRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmpleadoServiceImplements implements EmpleadoService{
    private final EmpleadoRepository empleadoRepository;

    public EmpleadoServiceImplements(EmpleadoRepository empleadoRepository){
        this.empleadoRepository = empleadoRepository;
    }


    @Override
    public List<Empleado> getAllEmpleados() {
        return empleadoRepository.findAll();
    }

    @Override
    public Empleado getEmpleadoById(Integer id) {
        return empleadoRepository.findById(id).orElse(null);
    }

    @Override
    public Empleado saveEmpleado(Empleado empleado) throws RuntimeException {
        return empleadoRepository.save(empleado);
    }

    @Override
    public Empleado updateEmpleado(Integer id, Empleado empleado) {
        Empleado empleadoExistente = empleadoRepository.findById(id).orElse(null);

        //Verificamos si encontramos algo
        if(empleadoExistente != null){
            empleadoExistente.setNombre_empleado(empleado.getNombre_empleado());
            empleadoExistente.setApellido_empleado(empleado.getApellido_empleado());
            empleadoExistente.setPuesto_empleado(empleado.getPuesto_empleado());
            empleadoExistente.setEmail_empleado(empleado.getEmail_empleado());

            //Guardamos el objeto modificado y lo retornamos
            return empleadoRepository.save(empleadoExistente);
        }

        return null;
    }

    @Override
    public void deleteEmpleado(Integer id) {
        //El repositorio id y lo borra en la base de datos
        empleadoRepository.deleteById(id);

    }
}