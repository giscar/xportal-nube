set scan off
CREATE OR REPLACE PACKAGE                "PKU_GESTOR_CM_LAUDOS" IS

  --consultoria nube migracion
  url_azure_app    varchar2(250):= 'https://zonasegura2.seace.gob.pe/documentos/';

 type ref_cursor is ref cursor;
 
procedure dojscript;

procedure uspcrearlaudocm(
  
  ag_trama_items            varchar2 default null,
  ag_numero_registro                 number ,
  ag_cod                             varchar2,  
  ag_tipo_arbitraje         VARCHAR2 ,
  ag_tipo_arbitro           VARCHAR2 ,  
  session__filesingedhttp   VARCHAR2 DEFAULT NULL,
  session__USERID           VARCHAR2 DEFAULT NULL,
  ag_archivo                varchar2 ,
  ag_archivo_laudo          varchar2 ,
  session__anhoentidad      varchar2,
  session__eue_codigo       varchar2 ,
  ag_archivo_declaracion    varchar2,
  ag_tipo_sede              varchar2,
  ag_tipo_secre             varchar2,
  ag_f_declaracion          varchar2,  
  ag_sec_arb_otro           varchar2,
  ag_f_inicio_proceso       varchar2,
  ag_f_emision              varchar2
  );

PROCEDURE uspPublicarLaudoCM(
    ag_reg_proceso            VARCHAR2 DEFAULT NULL,
    ag_orden_compra           VARCHAR2 DEFAULT NULL,
    ag_f_autoriza             VARCHAR2 DEFAULT NULL,
    pfiletoupload1            VARCHAR2 DEFAULT NULL,
    pfiletoupload2            VARCHAR2 DEFAULT NULL,
    pfiletoupload_file1       VARCHAR2 DEFAULT NULL,
    pfiletoupload_file2       VARCHAR2 DEFAULT NULL,
    pfilesize_file1           VARCHAR2 DEFAULT NULL,
    pfileSize_file2           VARCHAR2 DEFAULT NULL,
    ag_trama_items            VARCHAR2 DEFAULT NULL,
    session__USERID           VARCHAR2 DEFAULT NULL,
    session__IIS_REMOTE_ADDR  VARCHAR2,
    iisenv__REMOTE_HOST       VARCHAR2 ,
    ag_f_declaracion          VARCHAR2,
    ag_archivo_declaracion    VARCHAR2, 
    ag_archivo_laudo          VARCHAR2,
    WriteFileDirectoryDynamic VARCHAR2,
    ag_tipo_sede              VARCHAR2,
    ag_tipo_secre             VARCHAR2,
    ag_sec_arb_otro           VARCHAR2,
    ag_f_inicio_proceso       VARCHAR2,
    ag_f_emision              VARCHAR2, 
    ag_cuantia                VARCHAR2,
    
    ag_tipo_arbitraje         varchar2,
    ag_tipo_moneda            varchar2,
    ag_sec_arb_otro_mat        varchar2
    );

PROCEDURE uspVisualizarLaudoCM(
    ag_trama_items          varchar2 default null,
    ag_cod                  varchar2,
    ag_laudo                VARCHAR2,
    ag_tipo_arbitraje       VARCHAR2 ,
    ag_tipo_arbitro         VARCHAR2 ,
    session__filesingedhttp VARCHAR2 DEFAULT NULL,
    session__USERID         VARCHAR2 DEFAULT NULL,
    ag_f_declaracion        VARCHAR2 , 
    session__anhoentidad    VARCHAR2,
    session__eue_codigo     VARCHAR2 ,
    ag_tipo_sede            VARCHAR2,
    ag_tipo_secre           VARCHAR2 ,
    ag_sec_arb_otro         VARCHAR2,
    ag_f_inicio_proceso     VARCHAR2,
    ag_f_emision            VARCHAR2

);

 procedure uspSecretaria (
           ln_tipoArbitraje number,
           ln_secretaria number);
           
PROCEDURE uspBuscarMateria(
    codigo VARCHAR2 DEFAULT NULL);

END PKU_GESTOR_CM_LAUDOS;
/


CREATE OR REPLACE PACKAGE BODY                "PKU_GESTOR_CM_LAUDOS" IS

 PROCEDURE dojscript  is
 BEGIN
  usp_print('
  <script languaje=javascript>
  function alpha(e) {
    var tecla = document.all ? e.keyCode : e.which; 
    if (tecla==8) 
    return true; 
    patron =/[A-Za-zñÑáéíóúÁÉÍÓÚ\s]/;
    te = String.fromCharCode(tecla); 
    return patron.test(te); 
    }  
  <!--FIN  -->     
    
    
 function trim(stringToTrim) {
    return stringToTrim.replace(/\s/g,"");
      }

 function SoloNumerosNoDec(){

      //Solo permite ingreso de numeros del teclado superior, derecho sin punto decimal
      //inicio, fin, shift, control, etc

              var x = window.event.keyCode;   
              switch (x){
                  case 8: case 9: case 48: case 49: case 50: case 51: case 52: case 53: case 54: case 55: case 56: case 57: 
                      return;
                  default:
                      window.event.keyCode = 0;
                      break;
              }
          }
                 
         function ValidaRuc(obj){

      
          SoloNumerosNoDec();
                    if  (obj.value.length >= 11)
                    {
                    
                        window.event.keyCode = 0;
                    }   
                    else
                    {
                        return;
                    }
          }
  
  function VerOrden(orden,evt )
    {
       window.open("http://zonasegura.seace.gob.pe/portlet5open.asp?_portletid_=mod_cm_c012_gest_orden&scriptdo="+evt+"&v_ncor_orden="+orden,"","toolbar=no,Width=900,Height=800,scrollbars=yes,modal=yes,dependent,alwaysRaised");
    }
    
  </script> 
  ');

END; 
 
PROCEDURE uspCrearLaudoCM(  
  
ag_trama_items            VARCHAR2 DEFAULT NULL,  
ag_numero_registro                 number ,
ag_cod                             varchar2,  


ag_tipo_arbitraje                      VARCHAR2,  
ag_tipo_arbitro                        VARCHAR2,  

session__filesingedhttp   VARCHAR2 DEFAULT NULL,  
session__USERID           VARCHAR2 DEFAULT NULL,  
ag_archivo                            varchar2,  
ag_archivo_laudo                      varchar2,  
session__anhoentidad                  varchar2,  
session__eue_codigo                   varchar2,  
ag_archivo_declaracion                varchar2,  
ag_tipo_sede                          varchar2,  
ag_tipo_secre                         varchar2,  
ag_f_declaracion                      varchar2,  
ag_sec_arb_otro                       varchar2,  
ag_f_inicio_proceso                   varchar2,  
ag_f_emision                          varchar2
) 
is   
  ln_fecha                       date;   
  ln_tipoArbitraje               VARCHAR2(100); 
  ln_tipoarbitro                 VARCHAR2(100); 
  ln_tipomoneda                 VARCHAR2(100);
  ln_cod                         VARCHAR2(100); 
  ln_RUC_PRESIDENTE                   VARCHAR2(100); 
  ln_NOMBRE_PRESIDENTE                  VARCHAR2(4000); 
   
  ln_RUC_ARBITRO_ENTIDAD                VARCHAR2(100); 
  ln_NOMBRE_ARBITRO_ENTIDAD               VARCHAR2(4000); 
  
  ln_RUC_ARBITRO_CONTRATISTA              VARCHAR2(100); 
  ln_nombre_arbitro_contratista             varchar2(4000); 
  
  ln_numero_registro                         number;
  ln_desc_entidad     varchar(150);

  ln_num_orden                varchar2(100);
  v_vnum_ruc                  varchar2(11 byte);
  v_vraz_social               varchar2(500 byte);
  v_scriptdo_formato          varchar2(100);
  v_documento                 varchar2(50);
  v_fecha_creacion            date;
  v_monto_total               float(126);
    
  lv_combo_arbitraje           varchar2(4000);   
  lv_combo_arbitro             varchar2(4000); 
  lv_combo_tipo_moneda        varchar2(4000);
  lv_combo_sede                  varchar2(4000); 
  lv_combo_secre                 varchar2(4000); 
  
  ctipoArbitraje                ref_cursor;  
  ctipoarbitro                  ref_cursor;
  ctipomoneda                   ref_cursor;
  ctiposede                     ref_cursor;   
  ctiposecretaria               ref_cursor;
  
  lv_ruta_file                  varchar2(2000);    
  ln_archivo_declaracion        varchar2(4000);     
  ln_tipo_sede                  varchar2(4000);     
  ln_tipo_ssecre                varchar2(4000);       

--Cursor Datos de Arbitraje  
cursor c_cursor_arbitraje(p_n_num_registro in number, p_n_orden in varchar2) is    
  SELECT NCOR_ORDEN,    
  NUMERO_REGISTRO,    
  FECHA_INSTALACION,    
  TIPO_ARBITRAJE,    
  TIPO_ARBITRO,    
  RUC_PRESIDENTE,    
  NOMBRE_PRESIDENTE,    
  RUC_ARBITRO_ENTIDAD,     
  NOMBRE_ARBITRO_ENTIDAD,    
  ruc_arbitro_contratista,    
  NOMBRE_ARBITRO_CONTRATISTA    

from reg_procesos.cm_compras_arbitraje where ncor_orden =  p_n_orden and  NUMERO_REGISTRO = p_n_num_registro and ind_ultimo = 1 ;        

BEGIN      

dojscript  ; 
PKU_SS_FUNCIONES_JS.js_script('

  function SoloNumerosConDec(){
  
  //Solo permite ingreso de numeros del teclado superior, derecho y el punto
  //inicio, fin, shift, control, etc
  
      var x = window.event.keyCode;
      
      switch (x){
          case 8: case 9: case 46: case 48: case 49: case 50: case 51: case 52: case 53: case 54: case 55: case 56: case 57: 
              return;
          default:
              window.event.keyCode = 0;
              break;
      }
  } 

  function comparaFechas(fec1, fec2)
  {
  var Anio1 = (fec1).substr(6,4)
  var Mes1 = ((fec1).substr(3,2))*1 - 1
  var Dia1 = (fec1).substr(0,2)
  var Anio2 = (fec2).substr(6,4)
  var Mes2 = ((fec2).substr(3,2))*1 - 1
  var Dia2 = (fec2).substr(0,2)
  var Fecha_Inicio = new Date(Anio1,Mes1,Dia1)
  var Fecha_Fin = new Date(Anio2,Mes2,Dia2)
  if(Fecha_Inicio > Fecha_Fin)
  return 1;
  else
  {
  if(Fecha_Inicio < Fecha_Fin)
  return 2;
  else
  return 0;
  }
  }

  function eliminaMateria ()
   {
   
      var x=document.getElementById("entorno");
      
      if (x.value != "")
      {
        x.remove(x.selectedIndex);
        
        obj = document.getElementById("entorno");
        num =0; 
        
        thisform.ag_trama_items.value = "" ;
        
        for (i=0; opt=obj.options[i];i++)
        {
         if (opt.selected) num++; 
         
         if (thisform.ag_trama_items.value  != "")
            {
              thisform.ag_trama_items.value = thisform.ag_trama_items.value + "%"  +  obj.options[i].value + "#"  +  obj.options[i].text;  
            }
            else
            {
               thisform.ag_trama_items.value =   obj.options[i].value + "#"  +  obj.options[i].text;  
            }
        }
      }
      else
      {
          alert("Seleccione la Materia Controvertida a eliminar");
      
      }
   
   } 
  
    function Publicar() { 
     
    if (thisform.ag_tipo_arbitraje.value == "" )  { alert("Debe de ingresar la información del tipo de arbitraje"); return; }
    if (thisform.ag_tipo_moneda.value == "" )  { alert("Debe de ingresar el tipo de moneda para la cuantia de la controversia"); thisform.ag_tipo_moneda.focus() ; return; }
    if (thisform.ag_cuantia.value == "") { alert("Debe de ingresar la información de cuantia de la controversia"); thisform.ag_cuantia.focus() ; return; }
    if (thisform.ag_f_declaracion.value == "") { alert("Debe de ingresar la información del la fecha del documento de la declaración jurada");  return; }
    if (thisform.pfiletoupload1.value == "") { alert("Debe de ingresar la información del archivo de la declaración jurada");return; }
    if (thisform.ag_tipo_sede.value  == "") { alert("Debe de ingresar la información de la sede"); return; }
    if (thisform.ag_tipo_secre.value == "") { alert("Debe de ingresar la información de la secretaria arbitral"); return; }
    if (thisform.ag_sec_arb_otro.value == "" && (thisform.ag_tipo_secre.value == "291" || thisform.ag_tipo_secre.value == "293")) { alert("Debe de ingresar la información otro, secretaria arbitral"); thisform.ag_sec_arb_otro.focus; return; }
    if (thisform.ag_f_inicio_proceso.value == "") { alert("Debe de ingresar la información de la fecha de inicio del proceso arbitral"); return; }
    if (thisform.ag_f_emision.value == "") { alert("Debe de ingresar la información de la fecha de emisión del documento"); return; }
    if (thisform.pfiletoupload2.value == "") { alert("Debe de ingresar la información del archivo del Laudo Arbitral"); return; }
    
    if (comparaFechas(thisform.ag_fecha_audiencia.value,thisform.ag_f_emision.value) == 1 ){alert("La Fecha de Audiencia de Instalación debe ser anterior a la Fecha de Emisión del documento de Laudo Arbitral"); return;}
    if (comparaFechas(thisform.ag_f_declaracion.value,thisform.f_registro.value ) == 1 ){alert("La Fecha del Documento de la Declaración Jurada, debe ser igual o anterior a al día de hoy"); return;}
    if (comparaFechas(thisform.ag_f_emision.value,thisform.f_registro.value ) == 1 ){alert("La Fecha de emisión del documento del Laudo Arbitral, debe ser igual o anterior al día de hoy"); return;}
    
    if (thisform.ag_trama_items.value == "")
    {
      alert("Debe de ingresar la información de alguna Materia Controvertida");
       return;
    }
    
    if (trOtroMat.style.display == "" ){
    
      if (thisform.ag_sec_arb_otro_mat.value == "")
      {
         { alert("eber&aacute; de ingresar la informaci&oacute;n de Otra Materia Controvertida"); return; }
      }
    }

    if(thisform.pfiletoupload1.value != ""){
    
      extencion1 = thisform.pfiletoupload1.value;
      
      fileSize1 = $("#pfiletoupload1")[0].files[0].size;
      thisform.pfileSize_file1.value =fileSize1;
      
      extencion1 = extencion1.substring((extencion1.length)-4,extencion1.length)
      extencion1 = extencion1.replace(".", "");
      var namearchive="'||to_char(sysdate, 'ddmmyyyyHH24MISS')||'1."+extencion1;
      thisform.pfiletoupload_file1.value =namearchive;
            
      if (extencion1 != "doc" && extencion1 != "zip" && extencion1 != "pdf" && extencion1 != "docx" && extencion1 != "rar")
            {
               alert("El archivo de extensi\xf3n "+extencion1+" no est\xe1 permitido.");
               thisform.pfiletoupload1.focus();    
               return false;
            }
      }
      
    if(thisform.pfiletoupload2.value != ""){
    
      extencion1 = thisform.pfiletoupload2.value
      
      fileSize2 = $("#pfiletoupload2")[0].files[0].size;
      thisform.pfileSize_file2.value =fileSize2;
      
      extencion1 = extencion1.substring((extencion1.length)-4,extencion1.length)
      extencion1 = extencion1.replace(".", "");
      var namearchive="'||to_char(sysdate, 'ddmmyyyyHH24MISS')||'2."+extencion1;
      thisform.pfiletoupload_file2.value =namearchive;
      
      if (extencion1 != "doc" && extencion1 != "zip" && extencion1 != "pdf" && extencion1 != "docx" && extencion1 != "rar")
            {
               alert("El archivo de extensi\xf3n "+extencion1+" no est\xe1 permitido.");
               thisform.pfiletoupload2.focus();    
               return false;
            }
      }
      
        thisform.scriptdo.value = "publicarLaudoCM";
        
        if ( confirm("¿Esta Ud. seguro de publicar los cambios realizados?") )
        {
             thisform.submit();
        }      
  }
  
  function materia() {
  ventanaHija = window.open(''ControllerServletOpen?portletid=mod_cm_controversia_laudo&scriptdo=buscarMateria'','''',''toolbar =no,Width=700,Height=400,scrollbars=yes,modal =yes,dependent,alwaysRaised'') 
  }
    
  function RtnMateria( id, descripcion) { 
    
    var str = thisform.ag_trama_items.value;
    
    str = str.replace("("," ");
    str = str.replace(")"," ");
    descripcion = descripcion.replace("("," ");
    descripcion = descripcion.replace(")"," ");
        
    var n =str.search(descripcion);
    if (n ==-1) {    
     if (id == 310)
    { 
      trOtroMat.style.display = "";
    }
 
    if (thisform.ag_trama_items.value == null || thisform.ag_trama_items.value == "" ) { thisform.ag_trama_items.value = id + "#"+ descripcion ;
      }
    else
      { thisform.ag_trama_items.value = thisform.ag_trama_items.value + "%" + id + "#"+ descripcion ;
      } } var str                     = thisform.ag_trama_items.value;
      var f                           =str.split("%");
      var elSel                       = document.getElementById(''entorno'');
      for (x                          =0;
      x                               <elSel.length ;
      ){ elSel.remove(x);
      } for (x       =0;
      x              <f.length;
      x++){ var str  = f[x];
      var c          =str.split("#");
      var elOptNew   = document.createElement(''OPTION'');
      elOptNew.text  = c[1];
      elOptNew.value = c[0];
      var elSel      = document.getElementById(''entorno'');
      try { elSel.add(elOptNew, null);   // standards compliant; doesnt work in IE
      } catch(ex) { elSel.add(elOptNew); // IE only
      } } }
      
      
    function cargar(){
       document.write
  ("<div ><select  name=''entorno'' id=''entorno''  multiple=''multiple'' size = ''20''  style=''background: transparent;width:100%;padding: 0px;font-size: 12px;border: 0px transparent;height: 800px;'' ></div>");
      
      
          if (thisform.ag_trama_items.value != "") { var str= thisform.ag_trama_items.value;
                var f=str.split("%");
                for (x=0; x <f.length;x++){
                    var str = f[x];
                    var c =str.split("#");
                    //    document.write ("<option value="+ c[0] +">"+ c[1]  +"</option>");
                    document.write("</select></div>");
                    var elOptNew   = document.createElement(''OPTION'');
                    elOptNew.text  = c[1];
                    elOptNew.value = c[0];
                    var elSel      = document.getElementById(''entorno'');
                    try { elSel.add(elOptNew, null);   // standards compliant; doesnt work in IE
                    } catch(ex) { elSel.add(elOptNew); // IE only
                } }
            }        
        } 
        
    function activaOtraSecretaria()
    {
       if (thisform.ag_tipo_secre.value == "291" || thisform.ag_tipo_secre.value == "293")
       {
          trOtroSec.style.display = "";
       }
       else
       {
           trOtroSec.style.display = "none";
           thisform.ag_sec_arb_otro.value = "";
       }
    }
    
    function callSecretaria(v_proc_tipo,secretaria)
    {
       parametros="portletid=mod_cm_controversia_laudo&scriptdo=Secretaria&ln_tipoArbitraje="+ v_proc_tipo + "&secretaria=" + secretaria;
       getPortletAjax(divSecretaria, parametros)
    }
    ');  

    open ctipoarbitraje for
    select n_id_maestro,c_descripcion
    from arbitraje.tbl_arb_maestro where n_id_tipomaestro = 6;

    open ctipoarbitro for
    select n_id_maestro,c_descripcion
    from arbitraje.tbl_arb_maestro where n_id_tipomaestro = 23;

    open ctipomoneda for
    select n_id_maestro,c_descripcion
    from arbitraje.tbl_arb_maestro where n_id_maestro in (44,45); -- Soles y Dolares 
    
    for xrow in c_cursor_Arbitraje(ag_numero_registro,ag_cod) loop      
    begin                       
    LN_NUM_ORDEN:=   XROW.NCOR_ORDEN;
    ln_fecha :=   xrow.FECHA_INSTALACION  ;              
    ln_tipoArbitraje := xrow.TIPO_ARBITRAJE;              
    ln_tipoarbitro   :=   xrow.TIPO_ARBITRO;              
    ln_RUC_PRESIDENTE     := xrow.RUC_PRESIDENTE;                              
    ln_NOMBRE_PRESIDENTE :=  xrow.NOMBRE_PRESIDENTE ;              
    ln_RUC_ARBITRO_ENTIDAD  := xrow.RUC_ARBITRO_ENTIDAD;              
    ln_NOMBRE_ARBITRO_ENTIDAD :=  xrow.NOMBRE_ARBITRO_ENTIDAD;              
    ln_RUC_ARBITRO_CONTRATISTA := xrow.RUC_ARBITRO_CONTRATISTA;              
    ln_NOMBRE_ARBITRO_CONTRATISTA := xrow.NOMBRE_ARBITRO_CONTRATISTA;               
    ln_NUMERO_REGISTRO := xrow.NUMERO_REGISTRO;                     
    end;   
    
    end loop;                  

   if (LN_NUM_ORDEN is not null) then
          select v.entidad,
                 v.vnum_ruc,
                 v.vraz_social,
                 cm.scriptdo_formato,
                 v.doc_abreviatura||'-'||lpad(v.nro,6,'0')||'-'||v.anho documento,
                 v.fecha_creacion,
                 v.monto_total into 
                 ln_desc_entidad,
                 v_vnum_ruc,
                 v_vraz_social,
                 v_scriptdo_formato,
                 v_documento,
                 v_fecha_creacion,
                 v_monto_total
          from convenio.vw_cm_ordenes v inner join 
                   convenio.cm_convenio_marco cm on cm.ncor_cm = v.ncor_cm
              where v.ncor_orden = ln_num_orden and rownum=1;
  end if;

open ctiposede for    
select n_id_maestro, c_descripcion    
from arbitraje.tbl_arb_maestro where n_id_tipomaestro = 25;            
if  ln_tipoArbitraje = 24 then          

open ctiposecretaria for      
select n_id_maestro, c_descripcion      
from arbitraje.tbl_arb_maestro where n_id_tipomaestro = 2;        
else          
open ctiposecretaria for      
select n_id_maestro, c_descripcion      
from arbitraje.tbl_arb_maestro where n_id_tipomaestro = 26;       
end if;       

lv_combo_arbitraje  := PKU_SS_UTILES.f_retorna_combo(ctipoArbitraje, 'ag_tipo_arbitraje', ln_tipoArbitraje,'Seleccione...','style="width:260px" ; onchange = "callSecretaria(thisform.ag_tipo_arbitraje.value,0)"; ' );        
lv_combo_arbitro :=   PKU_SS_UTILES.f_retorna_combo(ctipoarbitro, 'ag_tipo_arbitro', ln_tipoarbitro,'Seleccione...','style="width:260px" onchange="arbitraje();" disabled = "true"');        
lv_combo_sede  := PKU_SS_UTILES.f_retorna_combo(ctiposede, 'ag_tipo_sede', ln_tipo_sede,'Seleccione...','style="width:260px" ' );         
lv_combo_secre  := PKU_SS_UTILES.f_retorna_combo(ctiposecretaria, 'ag_tipo_secre', ln_tipo_ssecre,'Seleccione...','style="width:260px"; onchange = "activaOtraSecretaria();" ' );        

--ln_tipomoneda := '44'; -- por defecto Soles
--lv_combo_tipo_moneda  := PKU_SS_UTILES.f_retorna_combo(ctipomoneda, 'ag_tipo_moneda', ln_tipomoneda,'Seleccione...','style="width:260px" ' );         
lv_combo_tipo_moneda  := PKU_SS_UTILES.f_retorna_combo(ctipomoneda, 'ag_tipo_moneda', null,null,'style="width:260px" ' );         

----------- CABECERA --------------------
 USP_PRINT('
    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform" >
    <tr>
      <td>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform">
            <tr>
            <td><h2>Registro de Laudo Arbitral de Compra por Acuerdo Marco</h2></td>
            <td align="right" valign=top width="50%">
                 <input type=button value="Publicar" onclick="Publicar();"> 
                 <input type=button value="Volver" onclick="thisform.scriptdo.value=''doView'';thisform.submit();">
            </td>
            </tr>
         </table>');
 USP_PRINT('</TD></TR>');
 USP_PRINT('</TABLE><br>');

 usp_print('
  <table class="table table-striped">');    

 usp_print('<tr><td colspan = "3"><h3>Datos de la Orden de Compra / Orden de Servicio</h3></td></tr>');
 usp_print('
    <input type="hidden" name="ag_orden_compra" value="'||LN_NUM_ORDEN||'" >
    <input type="hidden" value="" name="ag_trama_items" />  
    <tr>
      <td class=c1>Entidad Contratante</td>
      <td class=c2>'||ln_desc_entidad||'</td>
      <td class=c3><input type="hidden" name="v_vnum_ruc" value="'||v_vnum_ruc||'" ></td>      
    </tr>
    <tr>
      <td class=c1>Ruc Proveedor</td>
      <td class=c2>'||v_vnum_ruc||'</td>
      <td class=c3><input type="hidden" name="v_vnum_ruc" value="'||v_vnum_ruc||'" ></td>      
    </tr>
    <tr>
      <td class=c1>Proveedor</td>
      <td class=c2>'||v_vraz_social||'</td>
      <td class=c3><input type="hidden" name="v_vraz_social" value="'||v_vraz_social||'" ></td>
    </tr>
    <tr>
      <td class=c1>Documento</td>
      <td class=c2><a href="#" onclick="VerOrden('||LN_NUM_ORDEN||','''||v_scriptdo_formato||''')">'||v_documento||'</a></td>
      <td class=c3><input type="hidden" name="v_documento" value="'||v_documento||'" ></td>
    </tr>
    <tr>
      <td class=c1>Fecha del Documento</td>
      <td class=c2>'||to_char(v_fecha_creacion,'DD/MM/YYYY')||'</td>
      <td class=c3><input type="hidden" name="v_fecha_creacion" value="'||v_fecha_creacion||'" ></td>
    </tr>
    <tr>
      <td class=c1>Monto Total (S/.)</td>
      <td class=c2>'||to_char(v_monto_total, '999,999,999,990.99')||'</td>
      <td class=c3><input type="hidden" name="v_monto_total" value="'||v_monto_total||'" ></td>
    </tr>'); 

    usp_print(' <tr><td colspan = "3" ><h3>Datos del Arbitraje</h3></td></tr> ');                    
    usp_print(' <tr><td class=c1 width=33%>(*)Nro. de Registro de Proceso Arbitral</td> <td class=c2 width=33%>
    <input type="text" name="ag_reg_proceso" value="'|| ln_NUMERO_REGISTRO ||'" size=54 readonly></td> <td class=c3 width=34%>Muestra el Nro. de Registro de Proceso Arbitral</td> </tr> '    
    );                     
    
    usp_print(' <tr> <td class=c1 width=33%>(*)Fecha de Audiencia de Instalaci&oacute;n</td> <td class=c2 width=33%><input type="text" name="ag_fecha_audiencia" value="'|| to_char(ln_fecha, 'dd/mm/yyyy')  ||'" size=54 readonly></td> 
    <td class=c3 width=34%>Muestra la fecha de Audiencia de Instalaci&oacute;n</td> </tr> ');       
    usp_print(' <tr> <td class=c1 width=33%>(*)Tipo de Arbitraje</td> <td class=c2 width=33%>'||lv_combo_arbitraje||'</td> <td class=c3 width=34%>Seleccione el tipo de Arbitraje.</td> </tr>');                                  
    
    usp_print(' <tr> <td class=c1 width=33%>(*)Tipo de &Aacute;rbitro</td> <td class=c2 width=33%>'||lv_combo_arbitro||'</td> <td  class=c3 width=34%>Seleccione el tipo de &Aacute;rbitro.</td> </tr>');                            
    usp_print('<input type="hidden" value="' || to_char(sysdate,'dd/mm/yyyy')|| '" id="f_registro" name="f_registro"> '); 

    if   ln_tipoarbitro = 221  then                                                   
    usp_print(' <tr> <td class=c1 width=33%>(*)Presidente de Tribunal Arbitral</td> <td class=c2 width=33%><input type="text" name="ag_arbitro_presidente_desc" value="'|| ln_NOMBRE_PRESIDENTE ||'" size=54 readonly></td> 
    <td class=c3 width=34%>Muestra el nombre del Presidente del Tribunal Arbitral o &Aacute;rbitro &Uacute;nico</td> </tr> '    
    );                     
    
    usp_print(' <tr> <td class=c1 width=33%>(*)Arbitro designado por la entidad</td> <td class=c2 width=33%><input type="text" name="ag_arbitro_entidad_desc" value="'|| ln_NOMBRE_ARBITRO_ENTIDAD  ||'" size=54 readonly></td>
    <td class=c3 width=34%>Muestra el Arbitro designado por la Entidad</td> </tr> '    
    );                     
    
    usp_print(' <tr> <td class=c1 width=33%>(*)Arbitro designado por el Contratista</td> <td class=c2 width=33%><input type="text" name="ag_arbitro_contratista_desc" value="'|| ln_NOMBRE_ARBITRO_CONTRATISTA  ||'" size=54 readonly></td> 
    <td class=c3 width=34%>Muestra el &Aacute;rbitro designado por el Contratista</td> </tr> '
    );         
    end if;          
    
    if   ln_tipoarbitro = 220  then                            
    usp_print(' <tr> <td class=c1 width=33%>(*)&Aacute;rbitro &Uacute;nico</td> <td class=c2 width=33%><input type="text" name="ag_arbitro_presidente_desc" value="'|| ln_NOMBRE_PRESIDENTE ||'" size=54 readonly></td> 
    <td class=c3 width=34%>Muestra el nombre del Presidente del Tribunal Arbitral o &Aacute;rbitro &Uacute;nico</td> </tr> '    
    );          
    end if;          
    
    usp_print(' <tr> 
    <td class=c1 width=33%>(*)Cuantia de las Controversias</td> 
    <td class=c2 width=33%>
        <table>
            <tr>
                <td>'||lv_combo_tipo_moneda||'</td>
                <td>
                    <input type="text" name="ag_cuantia" value="" size=54   onkeyup="validarInputNumDecimal(this)" onblur="validarFormInputNumDecimal(this)">
                </td>
            </tr>
        </table>
    </td> 
    <td class=c3 width=34%>El monto debe registrarse en moneda nacional o en d&oacute;lares americanos, e incluye la Cuant&iacute;a de las controversias consignadas en la demanda y en la reconvenci&oacute;n, de ser el caso. </td> </tr> ' );                  
    
    usp_print('<tr><td colspan = "3" ><h3>Declaraci&oacute;n jurada de la veracidad y autenticidad del contenido del Laudo Arbitral</h3></td></tr> ');                            
    
    usp_print('<tr> <td class=c1 width=33%>(*)Fecha del Documento</td> <td class=c2 width=33%>
    <div class="input-group datepicker" id="idDivTxtFechaDoc">
            <div class="input-group-addon add-on">
            <span class="glyphicon glyphicon-calendar"></span>
    </div>
                 <INPUT  type=text readonly style="width:70%" data-format="dd/MM/yyyy" class="form-control" id="ag_f_declaracion" name="ag_f_declaracion"  size="10"  value="">
                 
            </div>   
    
    </td> <td class=c3 width=34%>Ingrese la fecha del documento que va adjuntar</td> </tr>
    ');
   
    usp_print(            
    PKU_PROCESOS_COMUN.f_putRowForm('(*)Archivo
    ', '<input type="file" id = "pfiletoupload1" name="pfiletoupload1" size="40" value="" > 
    <input type=hidden name=pfiletoupload_file1 value=""><input type=hidden name=pfileSize_file1 value=""><br> Tipos de archivo permitidos: *.doc, *.docx, *.pdf, *.zip, *.rar ',
    'Adjunte el archivo escaneado en donde se deja constancia expresa de la identidad y autenticidad de este documento,
    respecto al Laudo Arbitral que se notificar&aacute; en f&iacute;sico a las partes. Esta declaracion jurada debe contar con las firmas de los miembros del Tribunal Arbitral o el &Aacute;rbitro &Uacute;nico'));  
    
    usp_print(' <tr><td colspan = "3" ><h3>Laudo Arbitral</h3></td></tr> ');           
    usp_print(' <tr> <td class=c1 width=33%>(*)Sede</td> <td class=c2 width=33%>'||lv_combo_sede||'</td> <td class=c3 width=34%>Seleccione la sede del arbitraje</td> </tr>');                          
    
    usp_print(' <tr> <td class=c1 width=33%>(*)Secretar&iacute;a Arbitral</td> <td class=c2 width=33%>
    <div id = divSecretaria></div> </td> <td class=c3 width=34%>Seleccione el encargado de la Secretar&iacute;a Arbitral</td> </tr>                          
    <script> callSecretaria(thisform.ag_tipo_arbitraje.value,0); </script>'
    );
    usp_print(' <tr  id = "trOtroSec" style="display:none;"> <td class=c1 width=33%>(*)Otro,
    Secretar&iacute;a Arbitral </td> <td class=c2 width=33%><input type="text" name="ag_sec_arb_otro" value="" size=54 onkeypress= "return alpha(event)"></td> <td class=c3 width=34%>Señale la Secretar&iacute;a Arbitral encargada</td> </tr> '    
    );                                        
    
    usp_print(' <tr> <td class=c1 width=33%>(*)Fecha de Inicio del Proceso Arbitral</td> <td class=c2 width=33%>
    <div class="input-group datepicker" id="idDivTxtFechaIni">
            <div class="input-group-addon add-on">
            <span class="glyphicon glyphicon-calendar"></span>
    </div>
                 <INPUT  type=text readonly style="width:70%" data-format="dd/MM/yyyy" class="form-control" id="ag_f_inicio_proceso" name="ag_f_inicio_proceso"  size="10"  value="">
                 
                 
            </div>   
    </td> <td class=c3 width=34%>Seleccione la fecha de inicio del proceso arbitral seg&uacute;n corresponda</td> </tr> '    
    
    );                             
    
    usp_print(' <tr> <td class=c1 width=33%>(*)Fecha de emisi&oacute;n del documento</td> <td class=c2 width=33%>
    
    
    <div class="input-group datepicker" id="idDivTxtFechaEmi">
            <div class="input-group-addon add-on">
            <span class="glyphicon glyphicon-calendar"></span>
            </div>
      <INPUT  type=text readonly style="width:70%" data-format="dd/MM/yyyy" class="form-control" id="ag_f_emision" name="ag_f_emision"  size="10"  value="">
    </div>   
            
    </td> <td class=c3 width=34%>Seleccione la fecha de emisi&oacute;n del Documento</td> </tr> '    
    
    );             
    
    usp_print(            
    
    pku_procesos_comun.f_putrowform('(*)Archivo del Laudo Arbitral',                
    '<input type="file" id = "pfiletoupload2" name="pfiletoupload2" size="40" value="" >
    <input type=hidden name=pfiletoupload_file2 value=""><input type=hidden name=pfileSize_file2 value=""><br> Tipos de archivo permitidos: *.doc, *.docx, *.pdf, *.zip, *.rar ',                
    'Adjuntar el Archivo que contiene el Laudo Arbitral. No debe ser escaneado.'));                                  
    
    usp_print(' <tr> <td class=c1 width=33%>(*)Materia Controvertida</td> <td class=c2 width=33%></td> <td class=c3 width=34%> <input type=button value="Agregar" onclick="materia();"> <input type=button value="Eliminar"  onclick="eliminaMateria();"></td> </tr> '    
    
    );                 
    usp_print('<tr><div ><td colspan = "3" style="background: #cccccc ;">Descripci&oacute;n de la Materia Controvertida</td></div></tr>');     
    usp_print('<tr><td colspan = "3" ><script> cargar();   </script> </td></tr>');             
    
    usp_print(' <tr  id = "trOtroMat" style="display:none;"> <td class=c1 width=33%>(*)Otra Materia Controvertida </td> <td class=c2 width=33%><input type="text" name="ag_sec_arb_otro_mat" value="" size=54 onkeypress= "return alpha(event)">
    </td> <td class=c3 width=34%>Señale la Materia Controvertida</td> </tr> '    
    );                                        
        
    usp_print(' 
    </TABLE> <br/> <br/> ');                   


lv_ruta_file    := '\mon\docs\convenio\laudos\'|| session__anhoentidad||'\'||session__eue_codigo||'\';
usp_print('<input type="hidden" name="WriteFileDirectory"          value="FileSinged">');
usp_print('<input type="hidden" name="WriteFileDirectoryDynamic"   value="'||lv_ruta_file||'"></input>');
usp_print ( '<input name="session__FileSingedHTTP" type="hidden" value="' || session__filesingedhttp || '"></input>' );
usp_print('<input type="hidden"  value="'||ag_archivo_declaracion||'"  id="ag_archivo_declaracion" name="ag_archivo_declaracion">');
usp_print('<input type="hidden"  value="'||ag_archivo_laudo||'"  id="ag_archivo_laudo" name="ag_archivo_laudo">');

END;

PROCEDURE uspPublicarLaudoCM(
    ag_reg_proceso            VARCHAR2 DEFAULT NULL,
    ag_orden_compra           VARCHAR2 DEFAULT NULL,
    ag_f_autoriza             VARCHAR2 DEFAULT NULL,
    pfiletoupload1            VARCHAR2 DEFAULT NULL,
    pfiletoupload2            VARCHAR2 DEFAULT NULL,
    pfiletoupload_file1       VARCHAR2 DEFAULT NULL,
    pfiletoupload_file2       VARCHAR2 DEFAULT NULL,
    pfilesize_file1           VARCHAR2 DEFAULT NULL,
    pfileSize_file2           VARCHAR2 DEFAULT NULL,
    ag_trama_items            VARCHAR2 DEFAULT NULL,
    session__USERID           VARCHAR2 DEFAULT NULL,
    session__IIS_REMOTE_ADDR  VARCHAR2,
    iisenv__REMOTE_HOST       VARCHAR2 ,
    ag_f_declaracion          VARCHAR2,
    ag_archivo_declaracion    VARCHAR2, 
    ag_archivo_laudo          VARCHAR2,
    WriteFileDirectoryDynamic VARCHAR2,
    ag_tipo_sede              VARCHAR2,
    ag_tipo_secre             VARCHAR2,
    ag_sec_arb_otro           VARCHAR2,
    ag_f_inicio_proceso       VARCHAR2,
    ag_f_emision              VARCHAR2, 
    ag_cuantia                VARCHAR2,
    
    ag_tipo_arbitraje         VARCHAR2,
    ag_tipo_moneda            VARCHAR2,
    ag_sec_arb_otro_mat        varchar2
    )   
is
  cuenta          varchar2(4000);
  codigo          VARCHAR2(4000);
  codigo2          VARCHAR2(4000);
  codigo3          VARCHAR2(4000);
  codigo4          VARCHAR2(4000);
  descrip         VARCHAR2(4000) ;
  
  linkdeclaracion VARCHAR2(4000);
  linklaudo       VARCHAR2(4000);
  flag            number;
  laudo           number;
  x               NUMBER ;
  y              number ;
  
  LN_TIPO_DEMANDANTE NUMBER;
  LN_TIPO_ARBITRAJE  VARCHAR2(4000);
  LN_TIPO_ARBITRO VARCHAR2(4000);
  LN_FECHA_INSTALACION VARCHAR2(4000);
  LN_NCOR_ORDEN VARCHAR2(4000);
  LN_RUC_PRESIDENTE VARCHAR2(11);
  LN_ID_PRESIDENTE VARCHAR2(11);
  LN_NOMBRE_PRESIDENTE VARCHAR2(100);
  LN_RUC_ARBITRO_ENTIDAD VARCHAR2(11);
  LN_ID_ARBITRO_ENTIDAD VARCHAR2(11);
  LN_NOMBRE_ARBITRO_ENTIDAD VARCHAR2(100);
  LN_RUC_ARBITRO_CONTRATISTAS VARCHAR2(11);
  LN_ID_ARBITRO_CONTRATISTA VARCHAR2(11);
  ln_nombre_arbitro_contratista  varchar2(100);
  
  ln_ruc_contratista varchar2(11);
  
  ln_codconsucode     varchar2(11);
  ln_anhoentidad      varchar2(4);
  ln_ruc_entidad      varchar(11);
  ln_desc_entidad     varchar(150);
  
  ln_vnum_ruc                  varchar2(11 byte);
  ln_vraz_social               varchar2(500 byte);
  ln_documento                 varchar2(50);
  ln_abreviatura               varchar2(10);
  ln_fecha_creacion            date;
  ln_monto_total               float(126);
  
  ln_fecha_actual              date;

  
  var varchar(1000);
  
  CURSOR c_cursor( ag_trama_items IN VARCHAR )
  IS
      select x from (
      SELECT regexp_substr(ag_trama_items,'[^%]+', 1, level)x
      FROM dual
      CONNECT BY regexp_substr(ag_trama_items,'[^%]+', 1, level) IS NOT NULL
      )y where y.x is not null;

  BEGIN
   PKU_SS_CONTROVERSIAS.dojscript  ; 
  
  
  IF pfiletoupload_file1               IS NULL OR pfiletoupload_file1 = '' THEN
    linkdeclaracion              := ag_archivo_declaracion;
  ELSE
    linkdeclaracion := WriteFileDirectoryDynamic ||pfiletoupload_file1 ;
  END IF;
   IF pfiletoupload_file2               IS NULL OR pfiletoupload_file2 = '' THEN
    linklaudo                     := ag_archivo_laudo;
  else
    linklaudo := WriteFileDirectoryDynamic ||pfiletoupload_file2; 
  end if;
  
  ln_fecha_actual := sysdate;
  ------------------------
  --Insercion en Arbitraje
  ------------------------
 
              SELECT  TIPO_ARBITRAJE ,
                      TIPO_ARBITRO  ,
                      to_char(FECHA_INSTALACION,'dd/mm/yyyy') ,
                      NCOR_ORDEN ,
                      RUC_PRESIDENTE ,
                      NOMBRE_PRESIDENTE ,
                      RUC_ARBITRO_ENTIDAD ,
                      NOMBRE_ARBITRO_ENTIDAD ,
                      RUC_ARBITRO_CONTRATISTA ,
                      NOMBRE_ARBITRO_CONTRATISTA,
                      TIPO_DEMANDANTE
                      INTO
                      LN_TIPO_ARBITRAJE,
                      LN_TIPO_ARBITRO ,
                      LN_FECHA_INSTALACION ,
                      LN_NCOR_ORDEN,
                      LN_RUC_PRESIDENTE,
                      LN_NOMBRE_PRESIDENTE,
                      LN_RUC_ARBITRO_ENTIDAD,
                      LN_NOMBRE_ARBITRO_ENTIDAD,
                      LN_RUC_ARBITRO_CONTRATISTAS,
                      LN_NOMBRE_ARBITRO_CONTRATISTA,
                      LN_TIPO_DEMANDANTE              
              FROM 
              reg_procesos.cm_compras_arbitraje
              WHERE
              NCOR_ORDEN    = ag_orden_compra and 
              trim(RUC_PRESIDENTE) = trim(session__USERID) and
              numero_registro = ag_reg_proceso and
              ind_ultimo = 1;
              --Setea valores de un registro de arbitraje, numero de orden y arbitro
        
         IF (LN_NCOR_ORDEN is not null) THEN
                select v.codconsucode,
                       v.anhoentidad,
                       v.n_ruc,
                       v.entidad,
                       v.vnum_ruc,
                       v.vraz_social,
                       v.doc_abreviatura||'-'||lpad(v.nro,6,'0')||'-'||v.anho documento,
                       v.doc_abreviatura,
                       v.fecha_creacion,
                       v.monto_total
                       into
                       ln_codconsucode,
                       ln_anhoentidad,
                       ln_ruc_entidad,
                       ln_desc_entidad,                       
                       ln_vnum_ruc,
                       ln_vraz_social,
                       ln_documento,
                       ln_abreviatura,
                       ln_fecha_creacion,
                       ln_monto_total
                from convenio.vw_cm_ordenes v
                where v.ncor_orden = to_number(LN_NCOR_ORDEN,'999999999999') and rownum=1;
        END IF;
      
            IF LN_RUC_PRESIDENTE IS NOT NULL THEN
              BEGIN
              select a.N_ID_ARBITRO into LN_ID_PRESIDENTE from ARBITRAJE.TBL_ARB_ARBITRO a where a.C_RUC= LN_RUC_PRESIDENTE;
              EXCEPTION
              WHEN no_data_found THEN
              usp_print('
              <script language="javascript">
              alert("No se encuentra registrado el Presidente del Tribunal Arbitral o &Aacute;rbitro &Uacute;nico en el sistema..."); 
              </script>
              ');
              END;
            END IF;
            
            IF LN_RUC_ARBITRO_ENTIDAD IS NOT NULL THEN
              BEGIN
              select N_ID_ARBITRO into LN_ID_ARBITRO_ENTIDAD from ARBITRAJE.TBL_ARB_ARBITRO where C_RUC= LN_RUC_ARBITRO_ENTIDAD;
              EXCEPTION
              WHEN no_data_found THEN
              LN_ID_ARBITRO_ENTIDAD:= NULL;
              END;
            END IF;
               
            IF LN_RUC_ARBITRO_CONTRATISTAS IS NOT NULL THEN
              BEGIN
              select N_ID_ARBITRO into LN_ID_ARBITRO_CONTRATISTA from ARBITRAJE.TBL_ARB_ARBITRO where C_RUC= LN_RUC_ARBITRO_CONTRATISTAS;
              EXCEPTION
              WHEN no_data_found THEN
              LN_ID_ARBITRO_CONTRATISTA:= NULL;
              end;
            END IF;

/*        
usp_print('<br> D_REGISTRO_LAUDO_SEACE: '|| ln_fecha_actual);
usp_print('<br> CODCONSUCODE: '|| ln_codconsucode);
usp_print('<br> ANHOENTIDAD: '|| ln_anhoentidad);
usp_print('<br> C_RUC_ENTIDAD: '|| ln_ruc_entidad);
usp_print('<br> C_NOMBRE_ENTIDAD_SEACE: '|| ln_desc_entidad);
usp_print('<br> NCOR_ORDEN: '|| LN_NCOR_ORDEN);
usp_print('<br> RUC_PROVEEDOR: '|| ln_vnum_ruc);
usp_print('<br> C_NOMBRE_PROVEEDOR: '|| ln_vraz_social);
usp_print('<br> C_ORDEN_DOCUMENTO: '|| ln_documento);
usp_print('<br> D_ORDEN_FECDOC: '|| ln_fecha_creacion);
usp_print('<br> DOC_ABREVIATURA: '|| ln_abreviatura);
usp_print('<br> MONTO_TOTAL: '|| ln_monto_total);
usp_print('<br> CODIGO_CONTROVERSIA_SEACE: '|| TO_NUMBER(ag_reg_proceso, '999999999999'));
usp_print('<br> D_AUDIENCIA_INSTALACION: '|| ln_fecha_instalacion);
usp_print('<br> N_ID_MAESTRO_TIPO_DEMANDANTE: '|| to_number(ln_tipo_demandante, '999999999999'));
usp_print('<br> N_ID_MAESTRO_TIPO_ARBITRAJE: '|| to_number(ln_tipo_arbitraje, '999999999999'));
usp_print('<br> N_ID_MAESTRO_TIPO_ARBITRO: '|| to_number(ln_tipo_arbitro, '999999999999'));
usp_print('<br> N_ID_ARBITRO_UP: '|| to_number(ln_id_presidente, '999999999999'));
usp_print('<br> C_NOMBRES_UP: '|| ln_nombre_presidente);
usp_print('<br> N_ID_ARBITRO_ENTIDAD: '|| to_number(ln_id_arbitro_entidad, '999999999999'));
usp_print('<br> C_NOMBRES_ENTIDAD: '|| ln_nombre_arbitro_entidad);
usp_print('<br> N_ID_ARBITRO_CONTRATISTA: '|| to_number(ln_id_arbitro_contratista, '999999999999'));
usp_print('<br> C_NOMBRES_CONTRATISTA: '|| ln_nombre_arbitro_contratista);
usp_print('<br> N_ID_MONED_CONTROV_CUANTIA: '|| to_number(ag_tipo_moneda, '999999999999'));
usp_print('<br> N_CUANTIA_CONTROVERSIA: '|| to_number(ag_cuantia, '999999999999.99'' NLS_NUMERIC_CHARACTERS = ''.''' ));
usp_print('<br> C_RUC_ARBITRO_UP: '|| ln_ruc_presidente);
usp_print('<br> C_RUC_ARBITRO_ENTIDAD: '|| ln_ruc_arbitro_entidad);
usp_print('<br> C_RUC_ARBITRO_CONTRATISTA: '|| ln_ruc_arbitro_contratistas);
usp_print('<br> D_FECHA_DOCUMENTO: '|| ag_f_declaracion);
usp_print('<br> C_LINK_DECLARACION: '|| linkdeclaracion);
usp_print('<br> N_ID_MAESTRO_T_SEDES: '|| to_number(ag_tipo_sede, '999999999999'));
usp_print('<br> N_ID_MAESTRO_T_SECRETARIA: '|| to_number(ag_tipo_secre, '999999999999'));
usp_print('<br> C_COMENTARIOS_SECRETARIA: '|| ag_sec_arb_otro);
usp_print('<br> D_INICIO_PROCESO: '|| ag_f_inicio_proceso);
usp_print('<br> D_EMISION: '|| ag_f_emision );
usp_print('<br> C_LINK_LAUDO: '|| linklaudo);
usp_print('<br> C_OTROS_MATERIA_CONTROV: '|| ag_sec_arb_otro_mat);
usp_print('<br> C_ESTADO_REGISTRO: '|| 4);
usp_print('<br> D_FECHA_REGISTRO: '|| ln_fecha_actual);
usp_print('<br> N_ID_USUARIO_CREA: '|| session__userid);
usp_print('<br> D_USUARIO_CREA: '|| ln_fecha_actual);
            return;
*/             
          --------------------------------
          --Insercion en Sistema Arbitraje
          -------------------------------- 
          --inicio
          
     
          --sysdate,
            
              --1*/
          INSERT 
          into arbitraje.tbl_arb_laudo_cm
            ( N_ID_LAUDO,
              D_REGISTRO_LAUDO_SEACE,
              CODCONSUCODE,
              ANHOENTIDAD,
              C_RUC_ENTIDAD,
              C_NOMBRE_ENTIDAD_SEACE,
              NCOR_ORDEN,
              RUC_PROVEEDOR,
              C_NOMBRE_PROVEEDOR,
              C_ORDEN_DOCUMENTO,
              D_ORDEN_FECDOC,
              DOC_ABREVIATURA,
              MONTO_TOTAL,
              CODIGO_CONTROVERSIA_SEACE,
              D_AUDIENCIA_INSTALACION,
              N_ID_MAESTRO_TIPO_DEMANDANTE,
              N_ID_MAESTRO_TIPO_ARBITRAJE,
              N_ID_MAESTRO_TIPO_ARBITRO,
              N_ID_ARBITRO_UP,
              C_NOMBRES_UP,
              N_ID_ARBITRO_ENTIDAD,
              C_NOMBRES_ENTIDAD,
              N_ID_ARBITRO_CONTRATISTA,
              C_NOMBRES_CONTRATISTA,
              N_ID_MONED_CONTROV_CUANTIA,
              N_CUANTIA_CONTROVERSIA,
              C_RUC_ARBITRO_UP,
              C_RUC_ARBITRO_ENTIDAD,
              C_RUC_ARBITRO_CONTRATISTA,
              D_FECHA_DOCUMENTO,
              C_LINK_DECLARACION,
              N_SIZE_DECLARACION,
              N_ID_MAESTRO_T_SEDES,
              N_ID_MAESTRO_T_SECRETARIA,
              C_COMENTARIOS_SECRETARIA,
              D_INICIO_PROCESO,
              D_EMISION,
              C_LINK_LAUDO,
              N_SIZE_LAUDO,
              C_OTROS_MATERIA_CONTROV,
              C_ESTADO_REGISTRO,
              D_FECHA_REGISTRO,
              N_ID_USUARIO_CREA,
              D_USUARIO_CREA
            )                       
            VALUES
            ( arbitraje.SQ_ARB_LAUDO_CM.nextval,
              ln_fecha_actual,
              ln_codconsucode,
              ln_anhoentidad,
              ln_ruc_entidad,
              ln_desc_entidad,
              LN_NCOR_ORDEN,
              ln_vnum_ruc,
              ln_vraz_social,
              ln_documento,
              ln_fecha_creacion,
              ln_abreviatura,
              ln_monto_total,
              TO_NUMBER(ag_reg_proceso, '999999999999'),
              LN_FECHA_INSTALACION,
              to_number(LN_TIPO_DEMANDANTE, '999999999999'),
              TO_NUMBER(LN_TIPO_ARBITRAJE, '999999999999'),
              TO_NUMBER(LN_TIPO_ARBITRO, '999999999999'),
              TO_NUMBER(LN_ID_PRESIDENTE, '999999999999'),
              LN_NOMBRE_PRESIDENTE,
              TO_NUMBER(LN_ID_ARBITRO_ENTIDAD, '999999999999'),
              LN_NOMBRE_ARBITRO_ENTIDAD,
              TO_NUMBER(LN_ID_ARBITRO_CONTRATISTA, '999999999999'),
              ln_nombre_arbitro_contratista,
              TO_NUMBER(ag_tipo_moneda, '999999999999'),
              to_number(ag_cuantia, '999999999999.99',' NLS_NUMERIC_CHARACTERS = '',.''' ),
              ln_ruc_presidente,
              ln_ruc_arbitro_entidad,
              ln_ruc_arbitro_contratistas,
              ag_f_declaracion,
              linkdeclaracion,
              TO_NUMBER(pfilesize_file1,'999999999999'),
              to_number(ag_tipo_sede, '999999999999'),
              to_number(ag_tipo_secre, '999999999999'),
              ag_sec_arb_otro,
              ag_f_inicio_proceso,
              ag_f_emision,              
              linklaudo,
              TO_NUMBER(pfilesize_file2,'999999999999'),
              ag_sec_arb_otro_mat,
              4, --Deacuerdo al Sistema de Arbitraje: 0=Cancelado, 1=Nuevo, 2=Borrador, 3=Mofificado, 4=Publicado
              ln_fecha_actual,
              session__userid,
              ln_fecha_actual
              );
            
              for xrow in c_cursor(ag_trama_items) loop
                begin
                  select INSTR(xrow.x,'#', 1) "var" into cuenta FROM DUAL  ;
                  select substr(xrow.x,0,cuenta - 1 ) into  codigo  from dual;
                  select substr(xrow.x,cuenta + 1) into  descrip  from dual;
                  insert into arbitraje.tbl_arb_materias_controver_cm (n_id_materias_controv,n_id_laudo,n_id_maes_t_mate_contro,c_otros_especificacion,d_fecha_reg)--Registrar
                  values (ARBITRAJE.SQ_ARB_MATERIAS_CONTROVER_CM.NextVal,ARBITRAJE.SQ_ARB_LAUDO_CM.CURRVAL,codigo,ag_sec_arb_otro_mat,ln_fecha_actual);
                end;
              end loop;

  --Funciones generales tanto en actualizar como insertar
 
    update reg_procesos.cm_compras_arbitraje
    set
    tipo_arbitraje = ag_tipo_arbitraje,
    cod_laudo_cm = ARBITRAJE.SQ_ARB_LAUDO_CM.CURRVAL,
    FECHA_PUB_LAUDO = ln_fecha_actual
    where 
    numero_registro = ag_reg_proceso and ncor_orden=LN_NCOR_ORDEN and ind_ultimo = 1 ;
  
  COMMIT;
  usp_print
  (
    '<script language=javascript>           
    
    thisform.scriptdo.value="crearLaudoCM";      
    
    //thisform.submit();    
    
    </script>'
  )
  ;
END;

procedure uspVisualizarLaudoCM ( 
    ag_trama_items          varchar2 default null,
    ag_cod                  varchar2,
    ag_laudo                VARCHAR2,
    ag_tipo_arbitraje       VARCHAR2 ,
    ag_tipo_arbitro         VARCHAR2 ,
    session__filesingedhttp VARCHAR2 DEFAULT NULL,
    session__USERID         VARCHAR2 DEFAULT NULL,
    ag_f_declaracion        VARCHAR2 , 
    session__anhoentidad    VARCHAR2,
    session__eue_codigo     VARCHAR2 ,
    ag_tipo_sede            VARCHAR2,
    ag_tipo_secre           VARCHAR2 ,
    ag_sec_arb_otro         VARCHAR2,
    ag_f_inicio_proceso     VARCHAR2,
    ag_f_emision            VARCHAR2 )
IS
  ln_fecha DATE;
  ln_tipoArbitraje              VARCHAR2(100);
  ln_tipoarbitro                VARCHAR2(100);
  ln_tipomoneda                 VARCHAR2(100);
  ln_cod                        VARCHAR2(100);
  ln_RUC_PRESIDENTE             VARCHAR2(100);
  ln_NOMBRE_PRESIDENTE          VARCHAR2(4000);
  ln_MOTIVO_PRESIDENTE          VARCHAR2(100);
  ln_RUC_ARBITRO_ENTIDAD        VARCHAR2(100);
  ln_NOMBRE_ARBITRO_ENTIDAD     VARCHAR2(4000);
  ln_MOTIVO_ARBITRO_ENTIDAD     VARCHAR2(100);
  ln_RUC_ARBITRO_CONTRATISTA    VARCHAR2(100);
  ln_NOMBRE_ARBITRO_CONTRATISTA VARCHAR2(4000);
  ln_MOTIVO_ARBITRO_CONTRATISTA VARCHAR2(100);
  ln_NUMERO_REGISTRO            NUMBER;
  
  lv_combo_arbitraje            VARCHAR2(4000);
  lv_combo_arbitro              VARCHAR2(4000);
  lv_combo_tipo_moneda          VARCHAR2(4000);
  lv_combo_sede                 VARCHAR2(4000);
  lv_combo_secre                VARCHAR2(4000);
  ln_nom_contratista            VARCHAR2(4000);
  ln_procesos                   VARCHAR2(4000);
  ln_objeto                     VARCHAR2(4000);
  ln_monto FLOAT;
  ln_moneda  VARCHAR2(4000);
  ln_entidad VARCHAR2(4000);
  ctipoArbitraje ref_cursor;
  ctipoarbitro ref_cursor;
  ctipomoneda  ref_cursor;
  ctiposede ref_cursor;
  ctiposecretaria ref_cursor;
  ln_desc_entidad     varchar(150);
  ln_fecha_declaracion date;
  ln_archivo_declaracion varchar2(4000);
  ln_size_declaracion    varchar(50);
  ln_archivo_laudo       varchar2(4000);
  ln_size_laudo          varchar(50);
  lv_ruta_file           VARCHAR2(2000);
  lvtipodocumento        VARCHAR2(2000);
  lv_codtipofile         VARCHAR2(2000);
  ln_id_laudo      NUMBER;
  ln_trama               VARCHAR2(2000);
  ln_tipo_sede           VARCHAR2(4000);
  ln_tipo_ssecre         VARCHAR2(4000);
  ln_sede                VARCHAR2(4000);
  ln_secretaria          VARCHAR2(4000);
  ln_sec_arb_otro        VARCHAR2(4000);
  ln_f_inicio_proceso    VARCHAR2(4000);
  ln_f_emision           varchar2(4000) ;
  ln_cuantia             float;
  ln_c_otros_especificacion_mat varchar2(4000) ;
  
  v_vnum_ruc                  varchar2(11 byte);
  v_vraz_social               varchar2(500 byte);
  v_scriptdo_formato          varchar2(100);
  v_documento                 varchar2(50);
  v_fecha_creacion            date;
  v_monto_total               float(126);

  -- Obtenemos los datos del arbitraje y la orden.
    
  lv_rtn  VARCHAR(32000):= '';
  vc_cant NUMBER;
  
  --Cursor Datos de Laudo y arbitraje 
  cursor c_cursor_laudo(p_n_laudo in number, p_n_orden in varchar2) is
  select      n_id_laudo,
              codigo_controversia_seace,
              d_audiencia_instalacion,
              n_id_maestro_tipo_arbitraje,
              n_id_maestro_tipo_arbitro,
              c_nombres_up,
              c_nombres_entidad,
              C_NOMBRES_CONTRATISTA,
              n_id_moned_controv_cuantia,
              n_cuantia_controversia,
              d_fecha_documento,
              replace(c_link_declaracion,'\','/') c_link_declaracion,
              to_char(n_size_declaracion/1024/1024,'0.99') tamanio_declaracion,-- en MB
              N_ID_MAESTRO_T_SEDES,
              N_ID_MAESTRO_T_SECRETARIA,
              c_comentarios_secretaria,
              d_inicio_proceso,
              d_emision,
              replace(c_link_laudo,'\','/') c_link_laudo,
              to_char(N_SIZE_LAUDO/1024/1024,'0.99') tamanio_laudo,-- en MB
              C_OTROS_MATERIA_CONTROV
 from arbitraje.tbl_arb_laudo_cm 
 where n_id_laudo=p_n_laudo and ncor_orden=p_n_orden and c_estado_registro = 4;       
    
  CURSOR c_Materias( id_laudo IN VARCHAR2)
  IS
    SELECT ml.N_ID_MAES_T_MATE_CONTRO ,
      m.c_descripcion
    from arbitraje.tbl_arb_materias_controver_cm ml
    inner join arbitraje.tbl_arb_maestro m
    ON ml.N_ID_MAES_T_MATE_CONTRO = m.N_ID_MAESTRO
    where m.n_id_tipomaestro      = 28
    AND ml.n_id_laudo       = id_laudo;

BEGIN
 
    open ctipoarbitraje for
    select n_id_maestro,c_descripcion
    from arbitraje.tbl_arb_maestro where n_id_tipomaestro = 6;
  
    open ctipoarbitro for
    select n_id_maestro,c_descripcion
    from arbitraje.tbl_arb_maestro where n_id_tipomaestro = 23;
    
    open ctipomoneda for
    select n_id_maestro,c_descripcion
    from arbitraje.tbl_arb_maestro where n_id_maestro in (44,45); -- Soles y Dolares
  
  for xrow2 in c_cursor_laudo(ag_laudo,ag_cod)
  LOOP
    begin
      ln_id_laudo            := xrow2.n_id_laudo;
      ln_fecha_declaracion   := xrow2.d_fecha_documento;
      ln_archivo_declaracion := xrow2.c_link_declaracion;
      ln_size_declaracion    := xrow2.tamanio_declaracion;
      ln_archivo_laudo       := xrow2.c_link_laudo;
      ln_size_laudo          := xrow2.tamanio_laudo;
      ln_sede                := xrow2.N_ID_MAESTRO_T_SEDES;
      ln_secretaria          := xrow2.N_ID_MAESTRO_T_SECRETARIA;
      ln_sec_arb_otro        := xrow2.C_COMENTARIOS_SECRETARIA;
      ln_f_inicio_proceso    := xrow2.D_INICIO_PROCESO;
      ln_f_emision           := xrow2.D_EMISION;
      ln_cuantia             := xrow2.N_CUANTIA_CONTROVERSIA;
      ln_c_otros_especificacion_mat := xrow2.C_OTROS_MATERIA_CONTROV;
      ln_tipomoneda          := xrow2.n_id_moned_controv_cuantia;
      ln_fecha                      := xrow2.d_audiencia_instalacion ;
      ln_tipoarbitraje              := xrow2.n_id_maestro_tipo_arbitraje;
      ln_tipoarbitro                := xrow2.n_id_maestro_tipo_arbitro;
      ln_nombre_presidente          := xrow2.c_nombres_up ;
      ln_nombre_arbitro_entidad     := xrow2.c_nombres_entidad;
      ln_nombre_arbitro_contratista := xrow2.c_nombres_contratista;
      ln_numero_registro            := xrow2.codigo_controversia_seace;      
    end;
  END LOOP;
    
  if (ag_cod is not null) then
          select v.entidad,
                 v.vnum_ruc,
                 v.vraz_social,
                 cm.scriptdo_formato,
                 v.doc_abreviatura||'-'||lpad(v.nro,6,'0')||'-'||v.anho documento,
                 v.fecha_creacion,
                 v.monto_total 
                 INTO
                 ln_desc_entidad,
                 v_vnum_ruc,
                 v_vraz_social,
                 v_scriptdo_formato,
                 v_documento,
                 v_fecha_creacion,
                 v_monto_total
          from convenio.vw_cm_ordenes v inner join 
                   convenio.cm_convenio_marco cm on cm.ncor_cm = v.ncor_cm
              where v.ncor_orden = ag_cod and rownum=1;
  end if;
  
  lv_combo_arbitraje := PKU_SS_UTILES.f_retorna_combo(ctipoArbitraje, 'ag_tipo_arbitraje', ln_tipoArbitraje,'Seleccione...','style="width:260px"  disabled = "true" ' );
  lv_combo_arbitro   := PKU_SS_UTILES.f_retorna_combo(ctipoarbitro, 'ag_tipo_arbitro', ln_tipoarbitro,'Seleccione...','style="width:260px" " disabled = "true"');
  lv_combo_tipo_moneda  := PKU_SS_UTILES.f_retorna_combo(ctipomoneda, 'ag_tipo_moneda', ln_tipomoneda,'Seleccione...','style="width:260px" disabled = "true" ' );

  FOR xrow3          IN c_Materias(ln_id_laudo)
  LOOP
    BEGIN
      IF ln_trama IS NULL OR ln_trama = '' THEN
        ln_trama  := xrow3.N_ID_MAES_T_MATE_CONTRO || '#' || xrow3.c_descripcion ;
      ELSE
        ln_trama := ln_trama || '%' || xrow3.N_ID_MAES_T_MATE_CONTRO || '#' || xrow3.c_descripcion ;
      END IF;
    END;
  END LOOP;
  
  OPEN ctiposede FOR SELECT n_id_maestro,
  c_descripcion FROM arbitraje.tbl_arb_maestro WHERE n_id_tipomaestro = 25;
  IF ln_tipoArbitraje  = 24 THEN
    --institucional
    OPEN ctiposecretaria FOR SELECT n_id_maestro,
    c_descripcion FROM arbitraje.tbl_arb_maestro WHERE n_id_tipomaestro =2;
  ELSE
    --adhoc
    OPEN ctiposecretaria FOR SELECT n_id_maestro,
    c_descripcion FROM arbitraje.tbl_arb_maestro WHERE n_id_tipomaestro = 26;
  END IF;
  lv_combo_sede  := PKU_SS_UTILES.f_retorna_combo(ctiposede, 'ag_tipo_sede', ln_sede,'Seleccione...','style="width:260px" disabled = "true" ' );
  lv_combo_secre := PKU_SS_UTILES.f_retorna_combo(ctiposecretaria, 'ag_tipo_secre', ln_secretaria,'Seleccione...','style="width:700px"  disabled = "true"' );

dojscript;
PKU_SS_FUNCIONES_JS.js_script(
  '     
  function cargar_otra_materia(){

  if (trim(thisform.ag_sec_arb_otro_mat.value) != "" && trim(thisform.ag_sec_arb_otro_mat.value) != " "  )
      {
         trOtroMat.style.display = "";
      }
  }

  function cargar(){   

  document.write("<div id=''divDetalle''><select name=''entorno'' id=''entorno''  multiple=''multiple''  class=''table table-striped''>");                 
  
    if  (thisform.ag_trama_items.value  != "")          
    {           
      var str=  thisform.ag_trama_items.value;           
      var f=str.split("%");                         
      for (x=0;x<f.length;x++) {                                    
        var str=  f[x];                        
        var c=str.split("#");                     
    
        document.write("</select></div>");                        
        var elOptNew = document.createElement(''option'');                        
        elOptNew.text = c[1];                        
        elOptNew.value = c[0];                        
        var elSel = document.getElementById(''entorno'');                        
        try {                          
        elSel.add(elOptNew, null); // standards compliant; doesnt work in IE                        
        }                        
        catch(ex) {                          
        elSel.add(elOptNew); // IE only                        
        }                      
      }      
    }
  $("#entorno").css("height","250px");
  }
  ');

----------- CABECERA --------------------
 USP_PRINT('
    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform" >
    <tr>
      <td>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform">
            <tr>
            <td><h2>Detalle de Laudo Arbitral de Compra por Acuerdo Marco</h2></td>
            <td align="right" valign=top width="50%">
                 <input type=button value="Volver" onclick="thisform.scriptdo.value=''doView'';thisform.submit();">
            </td>
            </tr>
         </table>');
 USP_PRINT('</TD></TR>');
 USP_PRINT('</TABLE><br>');

 usp_print('
  <table class="table table-striped">');    

 usp_print('<tr><td colspan = "3"><h3>Datos de la Orden de Compra / Orden de Servicio</h3></td></tr>');
 usp_print('
    <input type="hidden"  name="ag_trama_items" value = "'|| ln_trama ||'"  />
    <tr>
      <td class=c1>Entidad Contratante</td>
      <td class=c2>'||ln_desc_entidad||'</td>
      <td class=c3><input type="hidden" name="v_vnum_ruc" value="'||v_vnum_ruc||'" ></td>      
    </tr>
    <tr>
      <td class=c1>Ruc Proveedor</td>
      <td class=c2>'||v_vnum_ruc||'</td>
      <td class=c3><input type="hidden" name="v_vnum_ruc" value="'||v_vnum_ruc||'" ></td>      
    </tr>
    <tr>
      <td class=c1>Proveedor</td>
      <td class=c2>'||v_vraz_social||'</td>
      <td class=c3><input type="hidden" name="v_vraz_social" value="'||v_vraz_social||'" ></td>
    </tr>
    <tr>
      <td class=c1>Documento</td>
      <td class=c2><a href="#" onclick="VerOrden('||ag_cod||','''||v_scriptdo_formato||''')">'||v_documento||'</a></td>
      <td class=c3><input type="hidden" name="v_documento" value="'||v_documento||'" ></td>
    </tr>
    <tr>
      <td class=c1>Fecha del Documento</td>
      <td class=c2>'||to_char(v_fecha_creacion,'DD/MM/YYYY')||'</td>
      <td class=c3><input type="hidden" name="v_fecha_creacion" value="'||v_fecha_creacion||'" ></td>
    </tr>
    <tr>
      <td class=c1>Monto Total (S/.)</td>
      <td class=c2>'||to_char(v_monto_total, '999,999,999,990.99')||'</td>
      <td class=c3><input type="hidden" name="v_monto_total" value="'||v_monto_total||'" ></td>
    </tr>');


usp_print('<tr><td colspan = "3" ><h3>Datos del Arbitraje</h3></td></tr>');
usp_print('<tr> <td class=c1 width=33%>(*)Nro. de Registro de Proceso Arbitral</td>    

<td class=c2 width=33%><input type="text" name="ag_reg_proceso" value="'|| ln_NUMERO_REGISTRO ||'" size=54 readonly></td>      

<td class=c3 width=34%>Muestra el Nro. de Registro de Proceso Arbitral</td>    

</tr>    

' );
  usp_print('    

<tr>   

<td class=c1 width=33%>(*)Fecha de Audiencia de Instalaci&oacute;n</td>    

<td class=c2 width=33%><input type="text" name="ag_fecha_audiencia" value="'|| to_char(ln_fecha, 'dd/mm/yyyy')  ||'" size=54 readonly></td>      

<td class=c3 width=34%>Muestra la fecha de Audiencia de Instalaci&oacute;n</td>    

</tr>    

');
  usp_print('    

<tr>   

<td class=c1 width=33%>(*)Tipo de Arbitraje</td>    

<td class=c2 width=33%>'||lv_combo_arbitraje||'</td>    

<td class=c3 width=34%>Muestra el tipo de Arbitraje.</td>    

</tr>');
  usp_print('    

<tr>   

<td class=c1 width=33%>(*)Tipo de &Aacute;rbitro</td>    

<td class=c2 width=33%>'||lv_combo_arbitro||'</td>    

<td class=c3 width=34%>Muestra el tipo de &Aacute;rbitro.</td>    

</tr>');
  IF ln_tipoarbitro = 221 THEN
    usp_print('    

<tr>   

<td class=c1 width=33%>(*)Presidente de Tribunal Arbitral</td>    

<td class=c2 width=33%><input type="text" name="ag_arbitro_presidente_desc" value="'|| ln_NOMBRE_PRESIDENTE ||'" size=54 readonly></td>      

<td class=c3 width=34%>Muestra el nombre del Presidente del Tribunal Arbitral o &Aacute;rbitro &Uacute;nico</td>    

</tr>    

' );
    usp_print('    

<tr>   

<td class=c1 width=33%>(*)&Aacute;rbitro designado por la entidad</td>    

<td class=c2 width=33%><input type="text" name="ag_arbitro_entidad_desc" value="'|| ln_NOMBRE_ARBITRO_ENTIDAD ||'" size=54 readonly></td>      

<td class=c3 width=34%>Muestra el &Aacute;rbitro designado por la Entidad</td>    

</tr>    

' );
    usp_print('    

<tr>   

<td class=c1 width=33%>(*)&Aacute;rbitro designado por el Contratista</td>    

<td class=c2 width=33%><input type="text" name="ag_arbitro_contratista_desc" value="'|| ln_NOMBRE_ARBITRO_CONTRATISTA ||'" size=54 readonly></td>      

<td class=c3 width=34%>Muestra el &Aacute;rbitro designado por el Contratista</td>    

</tr>    

' );
  END IF;
  IF ln_tipoarbitro = 220 THEN
    usp_print('    

<tr>   

<td class=c1 width=33%>(*)&Aacute;rbitro &Uacute;nico</td>    

<td class=c2 width=33%><input type="text" name="ag_arbitro_presidente_desc" value="'|| ln_NOMBRE_PRESIDENTE ||'" size=54 readonly></td>      

<td class=c3 width=34%>Muestra el nombre del Presidente del Tribunal Arbitral o &Aacute;rbitro &Uacute;nico</td>    

</tr>    

' );
  END IF;
  usp_print('    

<tr>   

<td class=c1 width=33%>(*)Cuantia de las Controversias</td>    

<td class=c2 width=33%>
  <table>
    <tr>
        <td>'||lv_combo_tipo_moneda||'</td>
        <td>
           <input type="text" name="ag_cuantia" value="'|| ln_cuantia ||'" size=54  onkeyup="validarInputNumDecimal(this)" onblur="validarFormInputNumDecimal(this)"  readonly> 
        </td>
    </tr>
  </table>
</td>      

<td class=c3 width=34%>Muestra la Cuant&iacute;a de las controversias consignadas en la demanda y en la reconvenci&oacute;n, de ser el caso.</td>    
</tr>    

' );
 usp_print('      
<tr><td colspan = "3" ><h3>Declaraci&oacute;n jurada de la veracidad y autenticidad del contenido del Laudo Arbitral</h3></td></tr>    
');
  usp_print('    
<tr>   
<td class=c1 width=33%>(*)Fecha del Documento</td>    
<td class=c2 width=33%><input    readOnly="true" type="text" name="ag_f_declaracion" onclick="calendario(this)" value="'|| ln_fecha_declaracion ||'" size=30 ></td>      
<td class=c3 width=34%>Muestra la fecha del documento que va adjuntar</td>     
</tr>    
' );
  --lvtipodocumento:=upper(SUBSTR(ln_archivo_declaracion,LENGTH(ln_archivo_declaracion)-2,LENGTH(ln_archivo_declaracion)));
  lvtipodocumento:=replace(upper(SUBSTR(ln_archivo_declaracion,LENGTH(ln_archivo_declaracion)-3,LENGTH(ln_archivo_declaracion))),'.','');
  BEGIN
    SELECT replace('bootstrap/'||icon_tipo_file, 'jpg', 'png') icon_tipo_file
    --icon_tipo_file
    INTO lv_codtipofile
    FROM Reg_procesos.tipo_archivo
    WHERE ext_tipo_file=lvtipodocumento;
  EXCEPTION
  when no_data_found then
    lv_codtipofile:= null;
  end;
  usp_print( pku_procesos_comun.f_putrowform('(*)Archivo', '<a href="'||url_azure_app|| ln_archivo_declaracion ||'" target="_BLANK">
            <img width="30" height="30" src="'|| lv_codtipofile ||  '" border="0" style="cursor:hand" /></a> (' ||ln_size_declaracion||') MB', 'Archivo escaneado de la Declaración Jurada de la veracidad'));
  usp_print('      

<tr> <td colspan=3><br/></td></tr>             
<tr><td colspan = "3" ><h3>Laudo Arbitral</h3></td></tr>    
');
  usp_print('    
<tr>   
<td class=c1 width=33%>(*)Sede</td>    
<td class=c2 width=33%>'||lv_combo_sede||'</td>    
<td class=c3 width=34%>Muestra la sede del arbitraje</td>    
</tr>');
  usp_print('    
<tr>   
<td class=c1 width=33%>(*)Secretar&iacute;a Arbitral</td>    
<td class=c2 width=33%>'||lv_combo_secre||'</td>    
<td class=c3 width=34%>Muestra el encargado de la Secretar&iacute;a Arbitral</td>    
</tr>');
  usp_print('    
<tr id = "trOtroSec"  style="display:none;">   
<td class=c1 width=33%>(*)Otro, Secretar&iacute;a Arbitral</td>    
<td class=c2 width=33%><input type="text" name="ag_sec_arb_otro" value="'|| ln_sec_arb_otro ||'" size=54 readonly ></td>      
<td class=c3 width=34%>Muestra la Secretar&iacute;a Arbitral encargada</td>    
</tr>    
' );
 PKU_SS_FUNCIONES_JS.js_script('
        if (thisform.ag_tipo_secre.value == "291" || thisform.ag_tipo_secre.value == "293")
       {
          trOtroSec.style.display = "";
       }
 '); 

  usp_print('    
<tr>   
<td class=c1 width=33%>(*)Fecha de Inicio del Proceso Arbitral</td>    
<td class=c2 width=33%><input  readOnly="true" type="text" name="ag_f_inicio_proceso"  value="'|| substr(ln_f_inicio_proceso, 0,10)  ||'" size=30></td>      
<td class=c3 width=34%>Muestra la fecha de inicio del proceso arbitral seg&uacute;n corresponda</td>    
</tr>    
' );
  usp_print('    
<tr>   
<td class=c1 width=33%>(*)Fecha de emisi&oacute;n del documento</td>    
<td class=c2 width=33%><input  readOnly="true" type="text" name="ag_f_emision"  value="'|| substr(ln_f_emision, 0,10)  ||'" size=30></td>      
<td class=c3 width=34%>Muestra la fecha de emisi&oacute;n del Documento</td>    
</tr>    
' );
  --lvtipodocumento:=upper(SUBSTR(ln_archivo_laudo,LENGTH(ln_archivo_laudo)-2,LENGTH(ln_archivo_laudo)));
  lvtipodocumento:=replace(upper(SUBSTR(ln_archivo_laudo,LENGTH(ln_archivo_laudo)-3,LENGTH(ln_archivo_laudo))),'.','');
  BEGIN
    SELECT replace('bootstrap/'||icon_tipo_file, 'jpg', 'png') icon_tipo_file
    --icon_tipo_file
    INTO lv_codtipofile
    FROM Reg_procesos.tipo_archivo
    WHERE ext_tipo_file=lvtipodocumento;
  EXCEPTION
  when no_data_found then
    lv_codtipofile:= null;
  end;
  usp_print( pku_procesos_comun.f_putrowform('(*)Archivo del Laudo Arbitral', '<a href="'||url_azure_app|| ln_archivo_laudo ||'" target="_BLANK">
  <img width="30" height="30" src="'|| lv_codtipofile ||'" border="0" style="cursor:hand" /></a>  (' ||ln_size_laudo||') MB', 'Archivo que contiene el Laudo Arbitral. No debe ser escaneado.'));
  usp_print('    
<tr>   
<td class=c1 width=33%>(*)Materia Controvertida</td>   
<td class=c2 width=33%></td>      
<td class=c3 width=34%></td>    
</tr>              
' );
  usp_print('<tr><div ><td colspan = "3" style="background: #cccccc ;"  >Descripci&oacute;n de la Materia Controvertida</td></div></tr>');
  usp_print('<tr><td colspan = "3" ><script>cargar();</script> </td></tr>');
  usp_print('<tr id = "trOtroMat" style="display:none;"> <td class=c1>(*)Otra Materia Controvertida </td> <td class=c2><input type="text" name="ag_sec_arb_otro_mat" value="'|| ln_C_OTROS_ESPECIFICACION_MAT ||'" size=54 >
             </td> <td class=c3>Muestra la Materia Controvertida</td> </tr> '); 
  usp_print('<tr><td colspan = "3" ><script>cargar_otra_materia();</script> </td></tr>');
  usp_print('                    
</table>        
<br/>        
<br/>        

');
  lv_ruta_file := '\mon\docs\convenio\laudos\'|| session__anhoentidad||'\'||session__eue_codigo||'\';                
usp_print('<input type="hidden" name="WriteFileDirectory" value="FileSinged">');  
usp_print('<input type="hidden" name="WriteFileDirectoryDynamic" value="'||lv_ruta_file||'"></input>');     
usp_print('<input name="session__FileSingedHTTP" type="hidden" value="'|| session__filesingedhttp|| '"></input>'   );          

END;

procedure uspSecretaria (
  ln_tipoArbitraje number,
  ln_secretaria number) 
is
ln_tipo_ssecre                    varchar2(4000);  
ctiposecretaria                   ref_cursor;   
lv_combo_secre                 varchar2(4000); 
 
begin
dojscript  ; 
if  ln_tipoArbitraje = 24 then          
--institucional      
open ctiposecretaria for      
select n_id_maestro, c_descripcion      
from arbitraje.tbl_arb_maestro where n_id_tipomaestro = 2;        
else          
--adhoc      
open ctiposecretaria for      
select n_id_maestro, c_descripcion      
from arbitraje.tbl_arb_maestro where n_id_tipomaestro = 26;       
end if;       
lv_combo_secre  := PKU_SS_UTILES.f_retorna_combo(ctiposecretaria, 'ag_tipo_secre', ln_secretaria,'Seleccione...','style="width:700px"; onchange = "activaOtraSecretaria();" ' );        
usp_print(lv_combo_secre);                            
end;

PROCEDURE uspBuscarMateria(
    codigo VARCHAR2 DEFAULT NULL)
IS
  CURSOR c_materia
  IS
    SELECT n_id_maestro,
      c_descripcion
    from arbitraje.tbl_arb_maestro m
    WHERE n_id_tipomaestro = 28 ;
BEGIN
  
  pku_ss_funciones_js.js_script('             
  function retornaMateria(id,descripcion){                    
  var wo = window.opener             
  wo.RtnMateria(id,descripcion)             
  window.close();                     
  }');
  
  usp_print('<table border="0" width=100% align=center class=''table table-striped'' cellpadding=3 cellspacing=0>             
            <tr><td align = "center" colspan = "3" ><h3>Nombre de Materia Controvertida</h3></td></tr> ' );
  FOR xrow IN c_materia
  LOOP
    BEGIN
      usp_print( '<tr><td> <input type=button value="..." onclick="retornaMateria(''' || xrow.n_id_maestro || ''',''' || xrow.c_descripcion ||''')"></td><td>' || xrow.c_descripcion || '</td></tr>' ) ;
    END;
  END LOOP;
  usp_print('</table>' );
END;
 
END PKU_GESTOR_CM_LAUDOS;
/
