

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>JSP Page</title>         
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
         
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        
        <script src = "http://ajax.googleapis.com/ajax/libs/angularjs/1.2.15/angular.min.js"></script>  
        
    </head>
    <style type="text/css">
        .messages {
            color: #FA787E;
        }
        form.ng-submitted input.ng-invalid{
            border-color: #FA787E;
        }
        form input.ng-invalid.ng-touched {
            border-color: #FA787E;
        }
    </style>
        
    <body>
        <div class="container-fluid" ng-app="Proyecto_ConsultorioOnline" ng-controller="pacienteController as cn">
            <form name="userForm" novalidate>
                <div class="row">
                    <div class="col-12">
                        <center><h1>Formulario Pacientes</h1></center>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <h3>Sección 1</h3>
                        <div class="row">
                            <div class="col-6">
                                <label >Identificación </label>
                                <input  name="identificacion_paciente" class="form-control" type="number" min="0" ng-model="cn.identificacion_paciente" ng-model-options="{updateOn: 'blur'}" required>
                            </div>
                            
                            <div class="col-6">
                                <label>Tipo identificación</label>
                                <select name="tipo_identificacion" class="form-control" ng-model="cn.tipo_identificacion" ng-model-options="{updateOn: 'blur'}" required>
                                    <option>CC</option>
                                    <option>TI</option>
                                </select>
                            </div>
                                                                                
                            
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <label >Nombres </label>
                                <input name="nombres" class="form-control" type="text" ng-model="cn.nombres" ng-model-options="{updateOn: 'blur'}" required>
                            </div>
                            
                            <div class="col-6">
                                <label>Apellidos</label>
                                <input name="apellidos" class="form-control" type="text" ng-model="cn.apellidos" ng-model-options="{updateOn: 'blur'}" required>
                            </div>
                            
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <label>Género</label>
                                <select name="genero" class="form-control" ng-model="cn.genero" ng-model-options="{updateOn: 'blur'}" required>
                                    <option>Masculino</option>
                                    <option>Femenino</option>
                                </select>
                            </div>
                            
                            <div class="col-6">
                                <label class="control-label">Edad</label>
                                <input name="edad" class="form-control" type="number" ng-model="cn.edad"  ng-model-options="{updateOn: 'blur'}" required>
                            </div>
                                                                                   
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <label>Dirección</label>
                                <input name="direccion" class="form-control" type="text" ng-model="cn.direccion" ng-model-options="{updateOn: 'blur'}" required>
                            </div>
                            
                            <div class="col-6">
                                <label>Teléfono</label>
                                <input name="telefono" class="form-control" type="number" ng-model="cn.telefono" ng-model-options="{updateOn: 'blur'}" required>
                            </div>
                                                                              
                        </div>
                        <div><br></div>
                        <h3>Sección 2</h3>
                        <div class="row">
                            <div class="col-3">
                                <input  class="btn btn-success" type="submit" ng-click="cn.guardarPaciente()" value="Guardar" ng-disabled="" />
                            </div>
                            <div class="col-3">
                                <button  class="btn btn-primary" ng-click="cn.listarPaciente()">Listar Paciente</button>
                            </div>
                            <div class="col-3">
                                <button  class="btn btn-danger" ng-click="cn.eliminarPaciente()">Eliminar Paciente</button>
                            </div>
                            <div class="col-3">
                                <button  class="btn btn-warning" ng-click="cn.actualizarPaciente()">Actualizar Paciente</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12 table-responsive-xl">
                        <h3>Sección 3</h3>
                        <table class="table table-striped table-hover">
                            <thead class="thead-dark">
                                <tr>  
                                    <th>identificacion_paciente</th>  
                                    <th>nombres</th>  
                                    <th>apellidos</th>  
                                    <th>genero</th>  
                                    <th>tipo_identificación</th>  
                                    <th>telefono</th>  
                                    <th>direccion</th>  
                                    <th>edad</th>  
                                </tr>  
                            </thead>
                            <tr ng-repeat = "paciente in cn.pacientes">  
                                <td>{{ paciente.identificacion_paciente}}</td>  
                                <td>{{ paciente.nombres}}</td>  
                                <td>{{ paciente.apellidos}}</td>  
                                <td>{{ paciente.genero}}</td>  
                                <td>{{ paciente.tipo_identificacion}}</td>  
                                <td>{{ paciente.telefono}}</td>  
                                <td>{{ paciente.direccion}}</td>  
                                <td>{{ paciente.edad}}</td>  
                            </tr> 
                        </table>
                    </div>
                </div>
            </form>
        </div>
    </body>
    <script>
        //codigo Angular
        angular.module('Proyecto_ConsultorioOnline', [])
                .controller('pacienteController', ['$scope', function ($scope) {
                 
                     $scope.user = {};
                     
                     $scope.update = function () {
                            console.log($scope.user);
                        };

                        $scope.reset = function (form) {
                            $scope.user = {};
                            if (form) {
                                form.$setPristine();
                                form.$setUntouched();
                            }
                        };

                        $scope.reset();
                        
        }]);
    
        var app = angular.module('Proyecto_ConsultorioOnline', []);
        app.controller('pacienteController', ['$http', controladorPacientes]);
        
        function validar() {
            return true;
        }
        
        function controladorPacientes($http) {
            
            var cn = this;
            
            cn.listarPaciente= function () {
                console.log('si ingresa al Angular listar');
                var url = "Peticiones.jsp";
                var params = {
                    proceso: "listarPaciente"
                };
                $http({
                    method: 'POST',
                    url: 'Peticiones.jsp',
                    params: params
                }).then(function (res) {
                    cn.pacientes = res.data.Pacientes;
                });
            };
            
            cn.guardarPaciente = function () {
                var paciente = {
                    proceso: "guardarPaciente",
                    identificacion_paciente: cn.identificacion_paciente,
                    nombres: cn.nombres,
                    apellidos: cn.apellidos,
                    genero: cn.genero,
                    tipo_identificacion: cn.tipo_identificacion,
                    telefono: cn.telefono,
                    direccion: cn.direccion,
                    edad: cn.edad
                };
                $http({
                    method: 'POST',
                    url: 'Peticiones.jsp',
                    params: paciente
                }).then(function (res) {
                    if (res.data.ok === true) {
                        if (res.data[paciente.proceso] === true) {
                            alert("Guardado con éxito");
                            //                                                            cn.listarContactos();
                        } else {
                            alert("Por favor vefifique sus datos");
                        }
                    } else {
                        alert(res.data.errorMsg);
                    }
                });

            };
            
            cn.eliminarPaciente = function () {
                var paciente = {
                    proceso: "eliminarPaciente",
                    identificacion_paciente: cn.identificacion_paciente
                };
                $http({
                    method: 'POST',
                    url: 'Peticiones.jsp',
                    params: paciente
                }).then(function (res) {
                    if (res.data.ok === true) {
                        alert("Eliminadooooo");
                        if (res.data[paciente.proceso] === true) {
                            alert("Eliminado con éxito");
                            //                                cn.listarContactos();
                        } else {
                            alert("Por favor vefifique sus datos");
                        }
                    } else {
                        alert(res.data.errorMsg);
                    }
                });

            };
            
             cn.actualizarPaciente = function () {

                var paciente = {
                    proceso: "actualizarPaciente",
                    identificacion_paciente: cn.identificacion_paciente,
                    nombres: cn.nombres,
                    apellidos: cn.apellidos,
                    genero: cn.genero,
                    tipo_identificacion: cn.tipo_identificacion,
                    telefono: cn.telefono,
                    direccion: cn.direccion,
                    edad: cn.edad
                };
                $http({
                    method: 'POST',
                    url: 'Peticiones.jsp',
                    params: paciente
                }).then(function (res) {
                    if (res.data.ok === true) {
                        if (res.data[paciente.proceso] === true) {
                            alert("Actualizar Paciente con éxito");
                            //                                cn.listarContactos();
                        } else {
                            alert("Por favor vefifique sus datos");
                        }
                    } else {
                        alert(res.data.errorMsg);
                    }
                });

            };
            
        }
        
    </script>
</html>


