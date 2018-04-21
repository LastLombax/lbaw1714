@extends('layout')

@section('title')
   Your Events | ReEvent
@endsection

@section('titleIcon')
    <i class="fas fa-calendar-check"></i>
@endsection

@section('pageTitle')
    Your Events
@endsection

@section('content')
<div class="container">
    <div id="nearby-events">
       <div class="bs-docs-section">
         <div class="row" style="width: 100%">

           <div class="col-lg-4">
             <div class="bs-ccomponent">
               <div class="card mb-4">
                 <h3 class="card-header" style="border-bottom: 10px solid #158cb8">Queima das Fitas</h3>
                 <div class="card-body">
                   <h6 class="card-subtitle text-muted">1 - 7 May, 2018</h6>
                 </div>
                 <img style="width: 100%; height: 200px; object-fit: cover;" src="img/queima.jpg" alt="Card image" title="">
                 <div class="card-body">
                   <p class="card-text">As Noites da Queima arrancam, este ano, no dia 7 de maio, ao som de James Arthur, Virgul e David Carreira.
                     A 8 de maio, Dillaz e Dub Inc têm a missão de animar a malta, antes de, na terça-feira dia 9, o grande
                     Quim Barreiros tome conta do palco e do espírito de todos os estudantes.</p>
                 </div>
                 <div class="card-footer text-muted">
                   <a href="#" class="card-link">Manage event</a>
                 </div>
               </div>
             </div>
           </div>

           <div class="col-lg-4">
             <div class="bs-ccomponent">
               <div class="card mb-4">
                 <h3 class="card-header" style="border-bottom: 10px solid #158cb8">Super Bock Super Bock</h3>
                 <div class="card-body">
                   <h6 class="card-subtitle text-muted">19 - 21 July, 2018</h6>
                 </div>
                 <img style="width: 100%; height: 200px; object-fit: cover;" src="img/superbock.jpg" alt="Card image" title="">
                 <div class="card-body">
                   <p class="card-text">O Super Bock Super Rock é um festival de música de Verão realizado anualmente em Portugal. É organizado
                     desde 1995 e é, actualmente, um dos mais importantes festivais portugueses.</p>
                 </div>
                 <div class="card-footer text-muted">
                   <a href="#" class="card-link">Manage event</a>
                 </div>
               </div>
             </div>
           </div>

           <div class="col-lg-4">
             <div class="bs-ccomponent">
               <div class="card mb-4">
                 <h3 class="card-header" style="border-bottom: 10px solid #158cb8">NOS Alive</h3>
                 <div class="card-body">
                   <h6 class="card-subtitle text-muted">12 - 14 July, 2018</h6>
                 </div>
                 <img style="width: 100%; height: 200px; object-fit: cover;" src="img/nos.png" alt="Card image">
                 <div class="card-body">
                   <p class="card-text">NOS Alive é um festival de música anual realizado no Passeio Maritimo de Algés, em Oeiras, Portugal. É
                     organizado pela promotora de eventos Everything Is New e patrocinado pela NOS.</p>
                 </div>
                 <div class="card-footer text-muted">
                   <a href="#" class="card-link">Manage event</a>
                 </div>
               </div>
             </div>
           </div>
         </div>
         <div>
             <ul class="pagination ">
               <li class="page-item disabled ">
                 <a class="page-link " href="# ">«</a>
               </li>
               <li class="page-item active ">
                 <a class="page-link " href="# ">1</a>
               </li>
               <li class="page-item ">
                 <a class="page-link " href="# ">2</a>
               </li>
               <li class="page-item ">
                 <a class="page-link " href="# ">3</a>
               </li>
               <li class="page-item ">
                 <a class="page-link " href="# ">»</a>
               </li>
             </ul>
           </div>
       </div>
     </div>
 </div>
@endsection




