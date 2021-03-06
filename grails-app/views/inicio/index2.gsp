<%@ page contentType="text/html;charset=UTF-8" %>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <title>${empr.empresa}</title>
    <meta name="layout" content="main"/>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">

    <link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    %{--<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>--}%


    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <style type="text/css">
    @page {
        size: 8.5in 11in;  /* width height */
        margin: 0.25in;
    }

    .item {
        width: 260px;
        height: 220px;
        float: left;
        margin: 4px;
        font-family: 'open sans condensed';
        border: none;

    }

    .imagen {
        width: 167px;
        height: 100px;
        margin: auto;
        margin-top: 10px;
    }

    .texto {
        width: 90%;
        height: 50px;
        padding-top: 0px;
        /*border: solid 1px black;*/
        margin: auto;
        margin: 8px;
        /*font-family: fantasy; */
        font-size: 16px;

        /*
                font-weight: bolder;
        */
        font-style: normal;
        /*text-align: justify;*/
    }

    .fuera {
        margin-left: 15px;
        margin-top: 20px;
        /*background-color: #317fbf; */
        background-color: rgba(200, 200, 200, 0.9);
        border: none;

    }

    .desactivado {
        color: #bbc;
    }

    .titl {
        font-family: 'open sans condensed';
        font-weight: bold;
        text-shadow: -2px 2px 1px rgba(0, 0, 0, 0.25);
    %{--<g:if test="${janus.Parametros.findByEmpresaLike('CNSL-GADLR')}">--}%
    <g:if test="${empr.empresa == message(code: 'ambiente2')}">
        color: #1a7031;
    </g:if>
    <g:else>
        color: #0070B0;
    </g:else>

        margin-top: 20px;
    }

    .bordes {
    %{--<g:if test="${janus.Parametros.findByEmpresaLike('CNSL-GADLR')}">--}%
    <g:if test="${empr.empresa == message(code: 'ambiente2')}">
        background: #1a7031;
    </g:if>
    <g:else>
        background: #2080b0;
    </g:else>

    }

    /*nuevo css    */

    #team {
        background: #eee !important;
        width: 98%;
    }

    .btn-primary:hover,
    .btn-primary:focus {
        background-color: #108d6f;
        border-color: #108d6f;
        box-shadow: none;
        outline: none;
    }

    .btn-primary {
        color: #fff;
        background-color: #007b5e;
        border-color: #007b5e;
    }

    section {
        padding: 15px 10px;
    }

    section .section-title {
        text-align: center;
        color: #007b5e;
        margin-bottom: 50px;
        text-transform: uppercase;
        height: 50%;

    }

    #team .card {
        border: none;
        background: #ffffff;
    }

    .image-flip:hover .backside,
    .image-flip.hover .backside {
        -webkit-transform: rotateY(0deg);
        -moz-transform: rotateY(0deg);
        -o-transform: rotateY(0deg);
        -ms-transform: rotateY(0deg);
        transform: rotateY(0deg);
        border-radius: .25rem;
    }

    .image-flip:hover .frontside,
    .image-flip.hover .frontside {
        -webkit-transform: rotateY(180deg);
        -moz-transform: rotateY(180deg);
        -o-transform: rotateY(180deg);
        transform: rotateY(180deg);
    }

    .mainflip {
        -webkit-transition: 1s;
        -webkit-transform-style: preserve-3d;
        -ms-transition: 1s;
        -moz-transition: 1s;
        -moz-transform: perspective(1000px);
        -moz-transform-style: preserve-3d;
        -ms-transform-style: preserve-3d;
        transition: 1s;
        transform-style: preserve-3d;
        position: relative;
    }

    .frontside {
        position: relative;
        -webkit-transform: rotateY(0deg);
        -ms-transform: rotateY(0deg);
        z-index: 2;
        margin-bottom: 25px;
        width: 300px;
        height: 220px;
    }

    .backside {
        position: absolute;
        top: 0;
        left: 0;
        background: white;
        -webkit-transform: rotateY(-180deg);
        -moz-transform: rotateY(-180deg);
        -o-transform: rotateY(-180deg);
        -ms-transform: rotateY(-180deg);
        transform: rotateY(-180deg);
        -webkit-box-shadow: 5px 7px 9px -4px rgb(158, 158, 158);
        -moz-box-shadow: 5px 7px 9px -4px rgb(158, 158, 158);
        box-shadow: 5px 7px 9px -4px rgb(158, 158, 158);
        width: 300px;
        height: 220px;
    }

    .frontside,
    .backside {
        -webkit-backface-visibility: hidden;
        -moz-backface-visibility: hidden;
        -ms-backface-visibility: hidden;
        backface-visibility: hidden;
        -webkit-transition: 1s;
        -webkit-transform-style: preserve-3d;
        -moz-transition: 1s;
        -moz-transform-style: preserve-3d;
        -o-transition: 1s;
        -o-transform-style: preserve-3d;
        -ms-transition: 1s;
        -ms-transform-style: preserve-3d;
        transition: 1s;
        transform-style: preserve-3d;
    }

    .frontside .card,
    .backside .card {
        min-height: 230px;
    }

    .backside .card a {
        font-size: 18px;
        color: #007b5e !important;
    }

    .frontside .card .card-title,
    .backside .card .card-title {
        color: #007b5e !important;
    }


    .frontside .card .card-body img {
        width: 120px;
        height: 120px;
        border-radius: 50%;
    }

    /*...............................................................*/

    .shape{
        border-style: solid; border-width: 0 70px 40px 0; float:right; height: 0px; width: 0px;
        -ms-transform:rotate(360deg); /* IE 9 */
        -o-transform: rotate(360deg);  /* Opera 10.5 */
        -webkit-transform:rotate(360deg); /* Safari and Chrome */
        transform:rotate(360deg);
    }
    .offer{
        background:#fff; border:1px solid #ddd; box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2); margin: 15px 0; overflow:hidden;
    }
    .offer:hover {
        -webkit-transform: scale(1.1);
        -moz-transform: scale(1.1);
        -ms-transform: scale(1.1);
        -o-transform: scale(1.1);
        /*transform:rotate scale(1.1);*/
        -webkit-transition: all 0.4s ease-in-out;
        -moz-transition: all 0.4s ease-in-out;
        -o-transition: all 0.4s ease-in-out;
        transition: all 0.4s ease-in-out;
    }
    .shape {
        border-color: rgba(255,255,255,0) #d9534f rgba(255,255,255,0) rgba(255,255,255,0);
    }
    .offer-radius{
        border-radius:7px;
    }
    .offer-danger {	border-color: #d9534f; }
    .offer-danger .shape{
        border-color: transparent #d9534f transparent transparent;
    }
    .offer-success {	border-color: #5cb85c; }
    .offer-success .shape{
        border-color: transparent #5cb85c transparent transparent;
    }
    .offer-default {	border-color: #999999; }
    .offer-default .shape{
        border-color: transparent #999999 transparent transparent;
    }
    .offer-primary {	border-color: #428bca; }
    .offer-primary .shape{
        border-color: transparent #428bca transparent transparent;
    }
    .offer-info {	border-color: #5bc0de; }
    .offer-info .shape{
        border-color: transparent #5bc0de transparent transparent;
    }
    .offer-warning {	border-color: #f0ad4e; }
    .offer-warning .shape{
        border-color: transparent #f0ad4e transparent transparent;
    }

    .shape-text{
        color:#fff; font-size:12px; font-weight:bold; position:relative; right:-40px; top:2px; white-space: nowrap;
        -ms-transform:rotate(30deg); /* IE 9 */
        -o-transform: rotate(360deg);  /* Opera 10.5 */
        -webkit-transform:rotate(30deg); /* Safari and Chrome */
        transform:rotate(30deg);
    }
    .offer-content{
        padding:10px 20px 10px;
    }
    @media (min-width: 487px) {
        .container {
            max-width: 750px;
        }
        .col-sm-6 {
            width: 50%;
        }
    }
    @media (min-width: 900px) {
        .container {
            max-width: 970px;
        }
        .col-md-4 {
            width: 33.33333333333333%;
        }
    }

    @media (min-width: 1200px) {
        .container {
            max-width: 1170px;
        }
        .col-lg-3 {
            width: 25%;
        }
    }

    a:hover{
        text-decoration: none;
    }

    </style>
</head>

<body>

<div style="text-align: center;"><h1 class="titl" style="font-size: 26px;">${empr.nombre}</h1></div>

<div class="container">
    <div class="row">
        <div class="col-md-4"></div>
        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
            <a href="#" class="">
                <div class="offer offer-info">
                    <div class="shape">
                        <div class="shape-text">
                            Clic
                        </div>
                    </div>
                    <div class="offer-content">
                        <div class="col-md-4">
                            <img class=" img-fluid" src="${resource(dir: 'images', file: 'compras.png')}" alt="card image">
                            <h3 class="lead" style="width: 200px; margin-left: 50px">
                                Compras P??blicas
                            </h3>
                        </div>
                        <p>
                            Clic, para continuar con la
                            <br> ??ltima acci??n registrada de este usuario.
                        </p>
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>

<section id="team" class="pb-5">
    <div class="container">
        %{--<h5 class="section-title h1">OUR TEAM</h5>--}%
        %{--<div style="text-align: center;"><h1 class="titl" style="font-size: 26px;">${empr.nombre}</h1></div>--}%
        <div class="row">
            <!-- Team member -->
            <div class="col-xs-12 col-sm-6 col-md-4">
                <div class="image-flip" ontouchstart="this.classList.toggle('hover');">
                    <div class="mainflip">
                        <div class="frontside">
                            <div class="card">
                                <div class="card-body text-center">
                                    %{--<p><img class=" img-fluid" src="https://sunlimetech.com/portfolio/boot4menu/assets/imgs/team/img_01.png" alt="card image"></p>--}%
                                    <p><img class=" img-fluid" src="${resource(dir: 'images', file: 'apu1.png')}" alt="card image"></p>
                                    <h4 class="card-title">Precios y an??lisis de precios unitarios</h4>
                                    <p class="card-text"></p>
                                    <a href="#" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i></a>
                                </div>
                            </div>
                        </div>
                        <div class="backside">
                            <div class="card">
                                <div class="card-body text-center mt-4">
                                    <h4 class="card-title">Precios y an??lisis de precios unitarios</h4>
                                    <p class="card-text">Registro y mantenimiento de
                                    ??tems y rubros. An??lisis de precios, rendimientos y listas de precios...</p>
                                    <ul class="list-inline">
                                        <li class="list-inline-item">
                                            <a  href="${createLink(controller: 'rubro', action: 'rubroPrincipal')}" title="An??lisis de Precios Unitarios" class="social-icon text-xs-center">
                                                <i class="fa fa-plus"></i>
                                            </a>
                                        </li>
                                        %{--<li class="list-inline-item">--}%
                                        %{--<a class="social-icon text-xs-center" target="_blank" href="#">--}%
                                        %{--<i class="fa fa-comment"></i>--}%
                                        %{--</a>--}%
                                        %{--</li>--}%
                                        %{--<li class="list-inline-item">--}%
                                        %{--<a class="social-icon text-xs-center" target="_blank" href="#">--}%
                                        %{--<i class="fa fa-skype"></i>--}%
                                        %{--</a>--}%
                                        %{--</li>--}%
                                        %{--<li class="list-inline-item">--}%
                                        %{--<a class="social-icon text-xs-center" target="_blank" href="#">--}%
                                        %{--<i class="fa fa-google"></i>--}%
                                        %{--</a>--}%
                                        %{--</li>--}%
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ./Team member -->
            <!-- Team member -->
            <div class="col-xs-12 col-sm-6 col-md-4">
                <div class="image-flip" ontouchstart="this.classList.toggle('hover');">
                    <div class="mainflip">
                        <div class="frontside">
                            <div class="card">
                                <div class="card-body text-center">
                                    <p><img class=" img-fluid" src="${resource(dir: 'images', file: 'obra100.png')}" alt="card image"></p>
                                    <h4 class="card-title">Obras</h4>
                                    <p class="card-text"></p>
                                    <a href="#" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i></a>
                                </div>
                            </div>
                        </div>
                        <div class="backside">
                            <div class="card">
                                <div class="card-body text-center mt-4">
                                    <h4 class="card-title">Obras</h4>
                                    <p class="card-text">Registro de Obras, georeferenciaci??n, los vol??menes de obra,
                                    variables de transporte y costos indirectos ...</p>
                                    <ul class="list-inline">
                                        <li class="list-inline-item">
                                            <a  href= "${createLink(controller:'obra', action: 'registroObra')}" title="Registro de Obras" class="social-icon text-xs-center">
                                                <i class="fa fa-plus"></i>
                                            </a>
                                        </li>
                                        %{--<li class="list-inline-item">--}%
                                        %{--<a class="social-icon text-xs-center" target="_blank" href="#">--}%
                                        %{--<i class="fa fa-comment"></i>--}%
                                        %{--</a>--}%
                                        %{--</li>--}%
                                        %{--<li class="list-inline-item">--}%
                                        %{--<a class="social-icon text-xs-center" target="_blank" href="#">--}%
                                        %{--<i class="fa fa-skype"></i>--}%
                                        %{--</a>--}%
                                        %{--</li>--}%
                                        %{--<li class="list-inline-item">--}%
                                        %{--<a class="social-icon text-xs-center" target="_blank" href="#">--}%
                                        %{--<i class="fa fa-google"></i>--}%
                                        %{--</a>--}%
                                        %{--</li>--}%
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ./Team member -->
            <!-- Team member -->
            <div class="col-xs-12 col-sm-6 col-md-4">
                <div class="image-flip" ontouchstart="this.classList.toggle('hover');">
                    <div class="mainflip">
                        <div class="frontside">
                            <div class="card">
                                <div class="card-body text-center">
                                    <p><img class=" img-fluid" src="${resource(dir: 'images', file: 'compras.png')}" alt="card image"></p>
                                    <h4 class="card-title">Compras P??blicas</h4>
                                    <p class="card-text"></p>
                                    <a href="#" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i></a>
                                </div>
                            </div>
                        </div>
                        <div class="backside">
                            <div class="card">
                                <div class="card-body text-center mt-4">
                                    <h4 class="card-title">Compras P??blicas</h4>
                                    <p class="card-text">plan anual de contrataciones, gesti??n de pliegos y
                                    control y seguimiento del PAC de obras ...</p>
                                    <ul class="list-inline">
                                        <li class="list-inline-item">
                                            <a  href= "${createLink(controller:'pac', action: 'registrarPac')}" title="Registro de Obras" class="social-icon text-xs-center">
                                                <i class="fa fa-plus"></i>
                                            </a>
                                        </li>
                                        %{--<li class="list-inline-item">--}%
                                        %{--<a class="social-icon text-xs-center" target="_blank" href="#">--}%
                                        %{--<i class="fa fa-twitter"></i>--}%
                                        %{--</a>--}%
                                        %{--</li>--}%
                                        %{--<li class="list-inline-item">--}%
                                        %{--<a class="social-icon text-xs-center" target="_blank" href="#">--}%
                                        %{--<i class="fa fa-skype"></i>--}%
                                        %{--</a>--}%
                                        %{--</li>--}%
                                        %{--<li class="list-inline-item">--}%
                                        %{--<a class="social-icon text-xs-center" target="_blank" href="#">--}%
                                        %{--<i class="fa fa-google"></i>--}%
                                        %{--</a>--}%
                                        %{--</li>--}%
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ./Team member -->
            <!-- Team member -->
            <div class="col-xs-12 col-sm-6 col-md-4">
                <div class="image-flip" ontouchstart="this.classList.toggle('hover');">
                    <div class="mainflip">
                        <div class="frontside">
                            <div class="card">
                                <div class="card-body text-center">
                                    <p><img class=" img-fluid" src="${resource(dir: 'images', file: 'fiscalizar.png')}" alt="card image"></p>
                                    <h4 class="card-title">Ejecuci??n</h4>
                                    <p class="card-text"></p>
                                    <a href="#" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i></a>
                                </div>
                            </div>
                        </div>
                        <div class="backside">
                            <div class="card">
                                <div class="card-body text-center mt-4">
                                    <h4 class="card-title">Sunlimetech</h4>
                                    <p class="card-text">This is basic card with image on top, title, description and button.This is basic card with image on top, title, description and button.This is basic card with image on top, title, description and button.</p>

                                    <div>
                                        <a class="social-icon text-xs-center" target="_blank" href="#">
                                            <i class="fa fa-twitter"> Link 1</i>
                                        </a>
                                    </div>
                                    <div>
                                        <a class="social-icon text-xs-center" target="_blank" href="#">
                                            <i class="fa fa-google"> Link 2</i>
                                        </a>
                                    </div>

                                    %{--<ul class="list-inline">--}%
                                        %{--<li class="list-inline-item">--}%
                                            %{--<a class="social-icon text-xs-center" target="_blank" href="#">--}%
                                                %{--<i class="fa fa-facebook">Link 1</i>--}%
                                            %{--</a>--}%
                                        %{--</li>--}%
                                        %{--<li class="list-inline-item">--}%
                                            %{--<a class="social-icon text-xs-center" target="_blank" href="#">--}%
                                                %{--<i class="fa fa-twitter">Link 2 </i>--}%
                                            %{--</a>--}%
                                        %{--</li>--}%
                                        %{--<li class="list-inline-item">--}%
                                            %{--<a class="social-icon text-xs-center" target="_blank" href="#">--}%
                                                %{--<i class="fa fa-skype"></i>--}%
                                            %{--</a>--}%
                                        %{--</li>--}%
                                        %{--<li class="list-inline-item">--}%
                                            %{--<a class="social-icon text-xs-center" target="_blank" href="#">--}%
                                                %{--<i class="fa fa-google"></i>--}%
                                            %{--</a>--}%
                                        %{--</li>--}%
                                    %{--</ul>--}%
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ./Team member -->
            <!-- Team member -->
            <div class="col-xs-12 col-sm-6 col-md-4">
                <div class="image-flip" ontouchstart="this.classList.toggle('hover');">
                    <div class="mainflip">
                        <div class="frontside">
                            <div class="card">
                                <div class="card-body text-center">
                                    <p><img class=" img-fluid"  src="${resource(dir: 'images', file: 'reporte.png')}" alt="card image"></p>
                                    <h4 class="card-title">Reportes</h4>
                                    <p class="card-text"></p>
                                    <a href="#" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i></a>
                                </div>
                            </div>
                        </div>
                        <div class="backside">
                            <div class="card">
                                <div class="card-body text-center mt-4">
                                    <h4 class="card-title">Sunlimetech</h4>
                                    <p class="card-text">.</p>
                                    <ul class="list-inline">
                                        <li class="list-inline-item">
                                            <a class="social-icon text-xs-center" target="_blank" href="#">
                                                <i class="fa fa-facebook"></i>
                                            </a>
                                        </li>
                                        <li class="list-inline-item">
                                            <a class="social-icon text-xs-center" target="_blank" href="#">
                                                <i class="fa fa-twitter"></i>
                                            </a>
                                        </li>
                                        <li class="list-inline-item">
                                            <a class="social-icon text-xs-center" target="_blank" href="#">
                                                <i class="fa fa-skype"></i>
                                            </a>
                                        </li>
                                        <li class="list-inline-item">
                                            <a class="social-icon text-xs-center" target="_blank" href="#">
                                                <i class="fa fa-google"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ./Team member -->
            <!-- Team member -->
            <div class="col-xs-12 col-sm-6 col-md-4">
                <div class="image-flip" ontouchstart="this.classList.toggle('hover');">
                    <div class="mainflip">
                        <div class="frontside">
                            <div class="card">
                                <div class="card-body text-center">
                                    <p><img class=" img-fluid" src="${resource(dir: 'images', file: 'manuales1.png')}"  alt="card image"></p>
                                    <h4 class="card-title">Manuales</h4>
                                    <p class="card-text"></p>
                                    <a href="#" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i></a>
                                </div>
                            </div>
                        </div>
                        <div class="backside">
                            <div class="card">
                                <div class="card-body text-center mt-4">
                                    <h4 class="card-title">Manuales</h4>
                                    <p class="card-text">This is basic card with image on top, title, description and button.This is basic card with image on top, title, description and button.This is basic card with image on top, title, description and button.</p>
                                    <ul class="list-inline">
                                        <li class="list-inline-item">
                                            <a class="social-icon text-xs-center" target="_blank" href="#">
                                                <i class="fa fa-facebook"></i>
                                            </a>
                                        </li>
                                        <li class="list-inline-item">
                                            <a class="social-icon text-xs-center" target="_blank" href="#">
                                                <i class="fa fa-twitter"></i>
                                            </a>
                                        </li>
                                        <li class="list-inline-item">
                                            <a class="social-icon text-xs-center" target="_blank" href="#">
                                                <i class="fa fa-skype"></i>
                                            </a>
                                        </li>
                                        <li class="list-inline-item">
                                            <a class="social-icon text-xs-center" target="_blank" href="#">
                                                <i class="fa fa-google"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ./Team member -->

        </div>
    </div>
</section>


<script type="text/javascript">
    $(".fuera").hover(function () {
        var d = $(this).find(".imagen")
        d.width(d.width() + 10)
        d.height(d.height() + 10)
//        $.each($(this).children(),function(){
//            $(this).width( $(this).width()+10)
//        });
    }, function () {
        var d = $(this).find(".imagen")
        d.width(d.width() - 10)
        d.height(d.height() - 10)
    })
</script>
</body>
</html>

%{--
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title></title>
    </head>
    <body>
    </body>
</html>--}%
