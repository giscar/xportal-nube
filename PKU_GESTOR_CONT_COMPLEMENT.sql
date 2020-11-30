set scan off;
CREATE OR REPLACE PACKAGE "PKU_GESTOR_CONT_COMPLEMENT" is

  -- Author  : GMILLONES
  -- Created : 21/05/2009 08:21:33 p.m.
  -- Purpose :

    --consultoria nube migracion
  url_azure_app    varchar2(250):= 'https://zonasegura2.seace.gob.pe/documentos/';

 TYPE ref_cursor IS REF CURSOR;

    gn_pagesize_contratos           number:= 20;
    gpk_aceptar                     varchar2(200):='images/Aceptar.gif';
--003-2019 SM alexander
  consucode2  varchar2(30) :='';
  proveedor2 varchar2(30) :='';
  proceso2 varchar2(30) :='';
  nconvoca2 varchar2(30) :='';
  fcontra2 varchar2(30) :='';
  npropuesta2 number;
  session_cod_contrato2 number;
  lb_validacion_rnp3 boolean:=true;
  lb_estado_inha2 varchar2(500) :='';
  lb_error2 BOOLEAN:=false;
    gpk_directorio_adicred  varchar2(200):= 'mon\docs\contratos';
 FUNCTION f_valida_rnp_contrato(
         ag_ruc_contratista   IN VARCHAR2,
         ag_n_convoca         IN VARCHAR2,
         ag_f_contrato        IN VARCHAR2,
         ag_n_propuesta        IN NUMBER,
         ag_estado_rnp       OUT VARCHAR2
         ) return BOOLEAN;

  function f_get_emp_dets (vc_cod_contrato number )return emp_dets_nt;

  -- fin 003-2019



 PROCEDURE uspLisProrrogasDoView
     (
       ag_ncor_orden_pedido        varchar2,
       ag_cm_opc                   varchar2,
       ag_cm_oper_compra           varchar2,
       session__userid             varchar2,
       session__N_CONVOCA          varchar2,
       session__COD_CONTRATO       varchar2,
       session__PUBLICADO          varchar2);

 PROCEDURE usp_registra_items(
       ag_trama_items              VARCHAR2,
       ag_n_cod_contrato           NUMBER,
       ag_nconvoca                 VARCHAR2);

 PROCEDURE uspNewProrrogaDoEdit
     (
       ag_cod_operacion         varchar2,
       ag_des_causa_renov       varchar2,
       ag_plazo                 varchar2, -- Se agrega para que Plazo del Contrato Complementario no se pierda
       ag_f_contrato            varchar2,
       ag_f_culminacion         varchar2,
       ag_n_contrato            varchar2,
       ag_cm_opc                varchar2,
       ag_cm_oper_compra        varchar2,
       session__N_CONVOCA       varchar2 default null,
       session__COD_CONTRATO    varchar2 default null,
       ag_trama_items           varchar2 default null,
       ag_trama_calendario      VARCHAR2 DEFAULT NULL,
       session__anhoentidad     VARCHAR2 DEFAULT NULL,
       session__eue_codigo      VARCHAR2 DEFAULT NULL,
       SizeFile                 varchar2--aramirez

       ) ;

 PROCEDURE uspProrrogaDoInsert
     ( ag_id_usuario                varchar2,
       ag_n_convoca                 varchar2,
       ag_cod_contrato_ren          varchar2,
       ag_n_contrato                varchar2,
       ag_cod_moneda                varchar2,
       ag_f_contrato                varchar2,
       ag_monto_adicional           varchar2,
       ag_des_causa_renov           varchar2,
       ag_des_contrato              varchar2,
       ag_plazo                     varchar2,
       ag_f_culminacion             varchar2,
       ag_codconsucode              varchar2,
       ag_anhoentidad               varchar2,
       ag_cod_operacion             varchar2,
       ag_ncor_orden_pedido         varchar2,
       ag_ind_siaf                  varchar2,
       ag_codconsucode_paga         varchar2,
       ag_anhoentidad_paga          varchar2,
       ag_ind_consorcio             varchar2,
       ag_ruc_contratista           varchar2,
       session__N_CONVOCA           VARCHAR2,
       ag_trama_calendario          varchar2,
       ag_trama_items               varchar2,
       pfiletoupload_file1             VARCHAR2,--aramirez
       session__eue_codigo            VARCHAR2 DEFAULT NULL ,--aramirez
       ag_fec_doc_adicional           VARCHAR2,--aramirez
       SizeFile                        varchar2,--aramirez
       session__COD_CONTRATO        varchar2 default null,
       ag_proc_tipo                 varchar2,
       session__USERID                 VARCHAR2, --aramirez
       iisenv__remote_host             VARCHAR2,--aramirez
       WriteFileDirectoryDynamic       VARCHAR2 --aramirez
       ) ;

  PROCEDURE uspNewProItemDoEdit
     ( ag_id_usuario            varchar2,
       ag_n_convoca             varchar2,
       ag_cod_contrato          varchar2,
       ag_n_contrato            varchar2,
       ag_cod_moneda            varchar2,
       ag_f_contrato            varchar2,
       ag_m_contratado          varchar2,
       ag_des_causa_renov       varchar2,
       ag_des_contrato          varchar2,
       ag_plazo                 varchar2,
       ag_f_culminacion         varchar2,
       ag_codconsucode          varchar2,
       ag_anhoentidad           varchar2,
       ag_cod_operacion         varchar2,
       ag_ncor_orden_pedido     varchar2,
       ag_cant_items            varchar2,
       ag_currenpage            varchar2,
       session__N_CONVOCA       varchar2 default null,
       session__COD_CONTRATO    varchar2 default null,
       ag_trama_calendario      varchar2 default null,
       ag_pagina_retorno        varchar2 default null,
          ag_proc_tipo                 varchar2);


  PROCEDURE uspManProrrogaDoEdit
     ( ag_cod_contrato          varchar2 DEFAULT Null,
       ag_cod_operacion         varchar2,
       ag_des_causa_renov       varchar2,
       ag_f_contrato            varchar2,
       ag_f_culminacion         varchar2,
       ag_n_contrato            varchar2,
       ag_cm_opc                varchar2,
       ag_cm_oper_compra        varchar2,
       session__userid          varchar2 default null,
       session__N_CONVOCA       varchar2 default null,
       session__COD_CONTRATO    varchar2 default null,
       ag_trama_items           VARCHAR2,
       ag_trama_calendario      VARCHAR2,
       ag_fec_doc_cgr                  VARCHAR2,                     -- del cgr
       ag_nro_doc_cgr                  VARCHAR2                     -- del cgr

       );

  PROCEDURE uspProrrogaDoUpdate
     ( ag_id_usuario           varchar2,
       ag_n_convoca            varchar2,
       ag_cod_contrato         varchar2,
       ag_cod_contrato_ren     varchar2,
       ag_n_contrato           varchar2,
       ag_cod_moneda           varchar2,
       ag_f_contrato           varchar2,
       ag_m_contratado         varchar2,
       ag_des_causa_renov      varchar2,
       ag_des_contrato         varchar2,
       ag_plazo                varchar2,
       ag_f_culminacion        varchar2,
       ag_cod_operacion        varchar2,
       ag_ncor_orden_pedido    varchar2,
       ag_ind_siaf             varchar2,
       ag_ind_consorcio        varchar2,
       ag_ruc_contratista      varchar2,
       session__N_CONVOCA      varchar2,
       ag_trama_calendario     varchar2,
       ag_trama_items          varchar2);

END PKU_GESTOR_CONT_COMPLEMENT;
/


CREATE OR REPLACE PACKAGE BODY PKU_GESTOR_CONT_COMPLEMENT is


-----------------------------------------------------------------------------------------------------------------
----------- PROCEDURE USP_REGISTRA_CALENDARIO -----------
-----------------------------------------------------------------------------------------------------------------

PROCEDURE usp_registra_calendario(ag_trama_calendario varchar2)
   IS

   v_parser  xmlparser.Parser;
   v_doc     xmldom.DOMDocument;
   v_nl      xmldom.DOMNodeList;
   v_n       xmldom.DOMNode;
   v_xml     VARCHAR2(20000);

   TYPE      tab_type IS TABLE OF reg_procesos.objeto%ROWTYPE;

   ln_num_pago    number;
   ld_fec_pago    date;
   ln_codmoneda   number;
   ln_montoPago   number(15,2);

   BEGIN

   v_xml              := ag_trama_calendario;
   v_parser           := xmlparser.newParser;
   xmlparser.setValidationMode (v_parser, FALSE);
   xmlparser.parseBuffer(v_parser, v_xml);
   v_doc              := xmlparser.getDocument(v_parser);
   xmlparser.freeParser(v_parser);

   v_nl := xslprocessor.selectNodes(xmldom.makeNode(v_doc),'/root/calendario');

  FOR cur_emp IN 0 .. xmldom.getLength(v_nl) - 1 LOOP
   v_n := xmldom.item(v_nl, cur_emp);

   ln_num_pago := xslprocessor.valueOf(v_n,'numpago');
   ld_fec_pago := to_date(xslprocessor.valueOf(v_n,'fecha'),'dd/mm/yyyy');
   ln_codmoneda := xslprocessor.valueof(v_n,'moneda');
   --ln_montoPago := xslprocessor.valueOf(v_n,'monto');
   ln_montoPago :=  to_number(xslprocessor.valueOf(v_n,'monto'),'999999999990.00');

    INSERT INTO reg_procesos.contrato_operacion_calendario
                (num_pago,
                 fec_pago,
                 codmoneda,
                 monto_pago)
         VALUES (ln_num_pago,
                 ld_fec_pago,
                 ln_codmoneda,
                 ln_montoPago);
   --    dbms_output.put_line(xslprocessor.valueOf(v_n,'CODOBJETO') || '<-->'||xslprocessor.valueOf(v_n,'DESCRIPCION'));

  END LOOP;
  xmldom.freeDocument(v_doc);


 END;


               ------------------------------------------------------------------------------------------------
/* FUNCION QUE HACE LA VALIDADCION DEL CONTRATISTA O CONSORCIO ANTES DE  REGISTRAR EL CONTRATO COMPLEMENTARIO INHABILITADOS VALIDACION*/
------------------------------------------------------------------------------------------------

FUNCTION f_valida_rnp_contrato(
         ag_ruc_contratista   IN VARCHAR2,
         ag_n_convoca         IN VARCHAR2,
         ag_f_contrato        IN VARCHAR2,
         ag_n_propuesta       IN NUMBER,
         ag_estado_rnp       OUT VARCHAR2
         ) return BOOLEAN
IS
 CURSOR cConsorcioMiembros(ruc_consorcio VARCHAR2,n_convoca NUMBER)
 is
   SELECT b.tipo,b.RUC_MIEMBRO,b.NOM_MIEMBRO
     FROM REG_PROCESOS.CONVOCATORIA_PROPUESTA a
    INNER JOIN  REG_PROCESOS.CONSORCIO_MIEMBRO b ON a.COD_CONSORCIO = b.COD_CONSORCIO
    WHERE a.RUC_POSTOR = ruc_consorcio
      AND a.N_CONVOCA = n_convoca;

      LB_RETORNO               BOOLEAN;
      lv_ruc_consorcio         VARCHAR2(50);
      lv_n_convoca             NUMBER;
      lv_id_consorcio          VARCHAR2(20);
      cant                     VARCHAR2(500);
      ln_proc_tipo             NUMBER;
      ln_valida_rucentidad     NUMBER;
      ld_f_contrato            DATE;
      ln_tipo_proceso           NUMBER; 
       mensaje_inhabi          VARCHAR2(500);
      lv_ruc_postor          VARCHAR2(20);


BEGIN

   lv_n_convoca     := to_number(ag_n_convoca);
  select p.ruc_postor into lv_ruc_postor from reg_procesos.convocatoria_propuesta p where p.n_convoca = lv_n_convoca and  p.n_propuesta=ag_n_propuesta ;

  lv_ruc_consorcio := lv_ruc_postor;

  lv_id_consorcio  := substr(lv_ruc_consorcio,0,1);
  ld_f_contrato    := to_date(ag_f_contrato,'dd/mm/yyyy');
  LB_RETORNO       := TRUE;
  ag_estado_rnp := '';
  mensaje_inhabi:= '';


  /*PARA EL DEMO SE QUITO LA VALIDACION */
 /*RETURN TRUE; */

----Sacamos el tipo de proceso y la entidad
  SELECT C.PROC_TIPO INTO ln_tipo_proceso FROM REG_PROCESOS.CONVOCATORIAS C WHERE C.N_CONVOCA = lv_n_convoca;   


  SELECT count(1) INTO ln_proc_tipo  FROM reg_procesos.convocatorias  WHERE n_convoca = ag_n_convoca  AND  proc_tipo in (11,23,40);   




    ----- Consorcio
      IF lv_id_consorcio = 'C' then

        FOR xrow IN cConsorcioMiembros(lv_ruc_consorcio,lv_n_convoca) LOOP

          select count(1) into ln_valida_rucentidad
                 from reg_procesos.entidades e where e.n_ruc = xrow.RUC_MIEMBRO
                 and e.anhoentidad = to_char(ld_f_contrato,'yyyy');

          -- verificamos que el postor NO sea una entidad
          IF  ln_valida_rucentidad = 0 THEN

	    cant :=reg_procesos.F_WS_RNP_GET_ESTADO_ACTUAL_ESP(xrow.RUC_MIEMBRO,to_char(ld_f_contrato,'yyyymmdd'));
       -- cant :='ERROR'; 
              -- IF cant <> '1-OK' THEN
              IF substr(cant,1,1) = '2' THEN
                mensaje_inhabi := 'El Proveedor del Consorcio: '||xrow.NOM_MIEMBRO||' se encuentra inhabilitado, no es posible publicar el contrato.';
                LB_RETORNO := FALSE;
                lb_error2:=false;
              END IF;

              IF UPPER(cant) LIKE '%ERROR%' THEN
                  mensaje_inhabi := 'Sistema externo no disponible, vuelva a intentar';
                  LB_RETORNO    := FALSE;
                  lb_error2 :=true;
              END IF;    
          END IF;

        END LOOP;

	ag_estado_rnp:=mensaje_inhabi;
      ELSE

          SELECT count(1) INTO ln_valida_rucentidad from reg_procesos.entidades e where e.n_ruc = lv_ruc_consorcio;

          IF ln_valida_rucentidad = 0 THEN
			cant := reg_procesos.F_WS_RNP_GET_ESTADO_ACTUAL_ESP(lv_ruc_consorcio,to_char(ld_f_contrato,'yyyymmdd'));
            -- cant :='ERROR'; 
            ---caso de de cant= 2-SE ENCUENTRA INHABILITADO
			-- IF cant <> '1-OK' THEN
            	IF substr(cant,1,1) = '2' THEN
               		mensaje_inhabi := 'El proveedor '||lv_ruc_consorcio||' se encuentra inhabilitado, no es posible publicar el contrato.';
                    LB_RETORNO := FALSE;
                    lb_error2:=false;
            	END IF;

           --- caso de de cant= 9-Error Llamada al Web Service - RNP
             IF UPPER(cant) LIKE '%ERROR%' THEN
                  	mensaje_inhabi := 'Sistema externo no disponible, vuelva a intentar';
                  	LB_RETORNO    := FALSE;
                    lb_error2 :=true;
              	END IF;                

            END IF;
	ag_estado_rnp:=mensaje_inhabi;
  END IF;  
RETURN LB_RETORNO;


END;

/*******************************************************************************/




-----------------------------------------------------------------------------------------------------------------
----------- PROCEDURE USP_REGISTRA_ITEMS -----------
-----------------------------------------------------------------------------------------------------------------

PROCEDURE usp_registra_items(
    ag_trama_items            VARCHAR2,
    ag_n_cod_contrato         NUMBER,
    ag_nconvoca               VARCHAR2 )
   IS

   v_parser  xmlparser.Parser;
   v_doc     xmldom.DOMDocument;
   v_nl      xmldom.DOMNodeList;
   v_n       xmldom.DOMNode;
   v_xml     VARCHAR2(20000);

   --TYPE      tab_type IS TABLE OF reg_procesos.objeto%ROWTYPE;

   ln_proc_item      NUMBER;
   ln_monto          NUMBER(15,2);
   ln_unmcodigo      NUMBER;
   ln_cantidad       NUMBER;

   BEGIN


   v_xml              := ag_trama_items;
   v_parser           := xmlparser.newParser;
   xmlparser.setValidationMode (v_parser, FALSE);
   xmlparser.parseBuffer(v_parser, v_xml);
   v_doc              := xmlparser.getDocument(v_parser);
   xmlparser.freeParser(v_parser);

   v_nl := xslprocessor.selectNodes(xmldom.makeNode(v_doc),'/root/i');

  DELETE FROM REG_PROCESOS.item_contrato WHERE n_cod_contrato = ag_n_cod_contrato;

  FOR cur_emp IN 0 .. xmldom.getLength(v_nl) - 1 LOOP
   v_n := xmldom.item(v_nl, cur_emp);

   ln_proc_item  :=  xslprocessor.valueOf(v_n,'item');
   ln_monto      :=  to_number(xslprocessor.valueOf(v_n,'mon'),'999999999990.00');
   ln_unmcodigo  :=  xslprocessor.valueOf(v_n,'unc');
   ln_cantidad   :=  xslprocessor.valueOf(v_n,'can');


   BEGIN

   INSERT INTO REG_PROCESOS.item_contrato
   (  n_cod_contrato,
      n_convoca,
      proc_item,
      monto,
      unm_codigo,
      cantidad,
      ncor_orden_pedido, /* SE DEBE MODIFICAR PARA Q SOPORTE CM*/
      f_registro,
      estado,
      F_ULT_MOD)
      VALUES(
      ag_n_cod_contrato,
      reg_procesos.f_get_max_n_convoca(ag_nconvoca),
      ln_proc_item,
      ln_monto,
      ln_unmcodigo,
      ln_cantidad,
      NULL,
      sysdate,
      1,
      sysdate) ;

    /*  EXCEPTION
         WHEN others THEN
           usp_print('Se produjo un error al registrar los items...');*/
  END;
  END LOOP;

  xmldom.freeDocument(v_doc);

 END;



       --------------
          function f_get_emp_dets (vc_cod_contrato number )

            return emp_dets_nt
        is
            return_value emp_dets_nt;
        begin
            select  emp_dets(b.codconsucode,  a.ruc_contratista,t.tip_abrev, b.n_convoca,a.f_contrato,a.n_propuesta)
            bulk collect into return_value
               FROM REG_PROCESOS.contrato a
                        join REG_PROCESOS.convocatorias b on a.n_convoca = b.n_convoca
                        left outer join SEASE.tipo_proceso t on t.tip_codigo = b.proc_tipo
                        left outer join REG_PROCESOS.t_tipo_subasta ts on b.cod_tipo_subasta = ts.cod_tipo_subasta
                        left outer join REG_PROCESOS.objeto o on b.codobjeto = o.codobjeto
                        left outer join REG_PROCESOS.monedas m on b.codmoneda = m.codmoneda
                        left outer join REG_PROCESOS.monedas mo on a.mon_codigo = mo.codmoneda

                    where a.n_cod_contrato = vc_cod_contrato;
            return return_value;
        end;

    ----------
  -- funcion para sacar el id_operacion cuando tengo el cod_adicional
   FUNCTION f_get_id_operacion (ag_cod_contrato IN NUMBER)
      RETURN NUMBER
   IS
      ln_id_operacion   NUMBER;
   BEGIN
      -- devuelve el objeto
      BEGIN


      SELECT DISTINCT a.id_operacion
        INTO ln_id_operacion
        FROM reg_procesos.contrato_operacion_calendario a,
             reg_procesos.contrato c
       WHERE c.n_cod_contrato =  ag_cod_contrato
         AND a.id_operacion   =  c.id_operacion;

      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            ln_id_operacion := NULL;
      END;

      RETURN ln_id_operacion;
   END;


 /***************************************************************/


  PROCEDURE uspLisProrrogasDoView
     (
       ag_ncor_orden_pedido      varchar2,
       ag_cm_opc                 varchar2,
       ag_cm_oper_compra         varchar2,
       session__userid           varchar2,
       session__N_CONVOCA        varchar2,
       session__COD_CONTRATO     varchar2,
       session__PUBLICADO        varchar2) IS
   ------- Cursores -------
   ------- Listado de Prorrogas ------
   Cursor c_prorrogas(p_n_convoca in number,
                      p_n_cod_contrato in number) is
    select distinct
            co.n_convoca,c.n_cod_contrato,c.n_contrato,
            c.n_cod_contrato_de_renovac,
            to_char(f_contrato,'dd/mm/yyyy') f_contrato,
            m.descripcion,c.m_contratado,
            c.des_contrato,c.plazo,
            to_char(f_culminacion,'dd/mm/yyyy') f_culminacion,
            c.cod_operacion_contrato
        from REG_PROCESOS.convocatorias co,
             REG_PROCESOS.contrato c,
             REG_PROCESOS.monedas m
        where c.n_convoca = p_n_convoca
          and c.n_cod_contrato_de_renovac = p_n_cod_contrato
          and c.cod_operacion_contrato = 2
          and co.n_convoca = c.n_convoca
          and c.codmoneda_contrato = m.codmoneda(+);

   ------- Listado de Complementarios ------
   Cursor c_complements(p_n_convoca in number,
                        p_n_cod_contrato in number) is
    select distinct
            co.n_convoca,c.n_cod_contrato,c.n_contrato,
            c.n_cod_contrato_de_renovac,
            to_char(f_contrato,'dd/mm/yyyy') f_contrato,
            m.descripcion,c.m_contratado,
            c.des_contrato,c.plazo,
            to_char(f_culminacion,'dd/mm/yyyy') f_culminacion,
            c.cod_operacion_contrato
        from REG_PROCESOS.convocatorias co,
             REG_PROCESOS.contrato c,
             REG_PROCESOS.monedas m
        where c.n_convoca = p_n_convoca
          and c.n_cod_contrato_de_renovac = p_n_cod_contrato
          and c.cod_operacion_contrato = 6
          and co.n_convoca = c.n_convoca
          and c.codmoneda_contrato = m.codmoneda(+);

   ------- Variables ------
   e_ArgumentosMalos    exception;
   ln_n_convoca         number;
   ln_cod_contrato      number;
   ln_n_contrato        REG_PROCESOS.contrato.n_contrato%type;
   lv_ruc_contratista   REG_PROCESOS.contrato.ruc_contratista%type;
   lv_nom_contratista   REG_PROCESOS.contrato.nom_contratista%type;
   lv_maxi              varchar2(50);
   lv_eue_codigo        varchar2(50);
   lv_anhoentidad       varchar2(50);
   lv_proc_sigla        varchar2(50);
   lv_proc_tipo_sigla   varchar2(50);
   lv_proc_num          varchar2(50);
   ln_proc_tipo         number;
   ln_n_proceso         number;
   lv_fecmax_prorroga   varchar2(50);
   lv_fecmax_complem    varchar2(50);
   lv_id_usuario        varchar2(50);
   v_cantidad             int;
   ag_f_vigencia_ini     varchar2(10);
   ag_f_vigencia_fin     varchar2(10);
   ln_modulo number;        -- (1/3) 12.09.2020 , permite verificar si las acciones sobre el contrato deben estas habilitados

  Begin
  v_cantidad:=0;
    pku_ss_contrato_adicionales.jscript_vigencia;

    if(session__COD_CONTRATO is not null)then
        ln_n_convoca := session__N_CONVOCA;
        ln_cod_contrato := session__COD_CONTRATO;
    else
        usp_print(
            pku_procesos_comun.f_putMensaje(
                'Visualice el contrato antes de seleccionar la acci&oacute;n.<br>Retorne a la Consola de Contratos ...',
                '')
        );
        return;
    end if;
  -- (2/3) 12.09.2020, obtiene el indicador que verifica que las acciones esten habilitadas
  select F_CON_CONTRATO_MOD('DESACTIVAR', 'ACCIONES',sysdate, session__COD_CONTRATO  ) into ln_modulo from dual;

    if( session__PUBLICADO <> 1 ) then
        usp_print(
            pku_procesos_comun.f_putMensaje(
                'Publique el contrato antes de seleccionar la acci&oacute;n.<br>Retorne a la Consola de Contratos ...',
                '')
     );
       return;
    end if;

    -------- Java Script -------
    REG_PROCESOS.PKU_GESTOR_CONT_FUNCIONES_JS_3.fEfecto_Imagenes_JS;

    ---- Verifico si se trabajara con los valores por defecto --
    ln_n_convoca := session__N_CONVOCA;
    ln_cod_contrato := session__COD_CONTRATO;
    lv_id_usuario:= trim(session__userid);

    ----- Obtener Datos de la Convocatoria-------
    if (ln_n_convoca is not null) then
        begin
           Select c.codconsucode,c.n_proceso,
                  c.anhoentidad,c.proc_tipo,c.proc_num,
                  c.proc_sigla,t.proc_tipo_sigla
           into   lv_eue_codigo,ln_n_proceso,
                  lv_anhoentidad,ln_proc_tipo,lv_proc_num,
                  lv_proc_sigla,lv_proc_tipo_sigla
           from REG_PROCESOS.convocatorias c,
                REG_PROCESOS.tipo_procesos t
           where t.proc_tipo = c.proc_tipo
             and c.n_convoca = ln_n_convoca;
          exception
             when no_data_found then
                  lv_eue_codigo:= null;
        end;
    end if;

    ----- Obtener Datos del Contrato ----
    begin
      Select c.n_contrato, c.ruc_contratista, c.nom_contratista
      into  ln_n_contrato, lv_ruc_contratista, lv_nom_contratista
      from REG_PROCESOS.contrato c
      where c.n_cod_contrato = ln_cod_contrato;
      exception
         when no_data_found then
              ln_n_contrato:= null;
    end;

     BEGIN

                select count(*) into v_cantidad
                from reg_procesos.contrato
                where n_cod_contrato = ln_cod_contrato
                and (f_vigencia_fin is null or f_vigencia_ini is null)
                and ind_version is null;

                if v_cantidad > 0 then
                select to_char(f_vigencia_ini, 'dd/mm/yyyy'), to_char(f_vigencia_fin, 'dd/mm/yyyy') into ag_f_vigencia_ini, ag_f_vigencia_fin
                from reg_procesos.contrato
                where n_cod_contrato = ln_cod_contrato
                and (f_vigencia_fin is null or f_vigencia_ini is null)
                and ind_version is null;
                end if;

      EXCEPTION
        WHEN NO_DATA_FOUND THEN
            ln_n_contrato := NULL;
        END;

    select trim(to_char(max(c.proc_item),'99999999'))
    into lv_maxi
    from reg_procesos.item_contrato c
    where  c.n_cod_contrato = ln_cod_contrato;

    -------- Titulos ------------

    usp_print('
    <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
        <tr>');
    usp_print(
            PKU_GESTOR_CONT_UTILES_3.f_get_titulo_contrato ( session__COD_CONTRATO, 'Prorrogas/Complementarios' )
    );
    usp_print('
            <td align="right" valign=top width="50%">
            <input type="hidden" name="v_cantidad" value="'||v_cantidad||'" >
     <input type="hidden" name="v_codigo" value="'||session__cod_contrato||'" >
     <input type="hidden" name="v_tipo" value="2" >
     ');
     if v_cantidad > 0 then 
        usp_print('<input type="button" value="Guardar Vigencia" onclick=Grabar_Vigencia()>');
         else 
          -- (3/3) 12.09.2020, obtiene el indicador que verifica que las acciones esten habilitadas
            if ln_modulo = 1 then 
               usp_print('<input type="button" value="Crear Prorroga/Complementario" OnClick="thisform.ag_edicion.value=''0'';thisform.scriptdo.value=''NewProrrogaDoEdit'';thisform.submit();"/>');
            end if;
      end if;

      usp_print('
      </td>
            <td>
                <input type="hidden" name="ag_id_usuario"                       value="'||lv_id_usuario||'" />
                <input type="hidden" name="ag_n_convoca"                        value="'||ln_n_convoca||'" />
                <input type="hidden" name="ag_cod_contrato"                     value="'||ln_cod_contrato||'" />
                <input type="hidden" name="ag_ncor_orden_pedido"                value="'||ag_ncor_orden_pedido||'" />
                <input type="hidden" name="ag_cm_opc"                           value="'||ag_cm_opc||'" />
                <input type="hidden" name="ag_cm_oper_compra"                   value="'||ag_cm_oper_compra||'" />
                <input type="hidden" name="ag_ini_editar" value="" />
                <input type="hidden" name="ag_edicion" value="" />
            </td>
        </tr>
    </table>
    <br>');


       usp_print
     ('<table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0 id="tbl_vigencia" style="display:none">
         <tr>
            <td colspan=8><h3>Indicar la vigencia del contrato</h3></td>
        </tr><tr>');

        usp_print('<tr><td class=c1 colspan=1>(*)Vigencia del contrato:</td><td class=c2 colspan=5>Inicio: <input class=CalSelect type="text" readonly name="ag_f_vigencia_ini" value="'
               || ag_f_vigencia_ini
               || '" size=16 '|| case when ag_f_vigencia_ini is not null then '' else ' onclick="calendario(this)" ' end ||'>&nbsp;&nbsp;Fin: <input class=CalSelect type="text" readonly name="ag_f_vigencia_fin" value="'
               || ag_f_vigencia_fin
               || '" size=16 '|| case when ag_f_vigencia_fin is not null then '' else ' onclick="calendario(this)" ' end ||'></td><td class=c3 colspan=2>&nbsp;Vigencia del contrato original</td></tr>');

        usp_print('        </tr>
       <br/>
        </table>
        ');


    ------ Obtener la ultima fecha de Prorroga ---------------
    select to_char(max(f_contrato), 'dd/mm/yyyy')
    into lv_fecmax_prorroga
    from REG_PROCESOS.convocatorias co, REG_PROCESOS.contrato c
    where co.n_convoca                   = c.n_convoca
      and c.n_convoca                    = ln_n_convoca
      and c.n_cod_contrato_de_renovac    = ln_cod_contrato
      and c.cod_operacion_contrato       = 2;

    ------ Cabecera de Columnas --------
    usp_print('
    <table border="0" width=100% class="table table-striped table-bordered table-hover dataTable no-footer">
        <tr>
            <td colspan=8>
              <h3>Prorrogas</h3>
            </td>
        </tr>
        <tr>
            <td class="th1"><b>Contrato Prorrogado Nro.</b></td>
            <td class="th1"><b>Fecha de la prorroga</b></td>
            <td class="th1"><b>Moneda</b></td>
            <td class="th1"><b>Monto de la prorroga</b></td>
            <td class="th1"><b>Objeto del Contrato</b></td>
          	<td class="th1"><b>Plazo de la prorroga</b></td>
            <td class="th1"><b>Fecha de Culminacion de la prorroga</b></td>
        </tr>
    ');

   for cp in c_prorrogas(ln_n_convoca,ln_cod_contrato) loop
      begin
         usp_print('
         <tr>
            <td>
              <b>'||makea('scriptdo=ManProrrogaDoEdit&ag_cod_operacion=2&ag_f_culminacion='||cp.f_culminacion||'&ag_ini_editar=1&ag_n_contrato='||cp.n_contrato||'&ag_n_convoca='||ln_n_convoca||'&ag_cod_contrato='||cp.n_cod_contrato||'&ag_cod_contrato_ren='||cp.n_cod_contrato_de_renovac,cp.n_contrato)||'</b>
            </td>
            <td>'||cp.f_contrato||'</td>
            <td>'||cp.descripcion||'</td>
            <td>'||cp.m_contratado||'</td>
            <td>'||cp.des_contrato||'</td>
            <td>'||cp.plazo||'</td>
            <td>'||cp.f_culminacion||'</td>
           </tr>
            ');
       end;
   end loop;

   usp_print('
        </table>
        <br/>
        <br/>
        ');

   ------ COMPLEMENTARIO --------
   if (ln_n_convoca is not null) then
       begin
           usp_print('
                <table border="0" width=100% class="table table-striped table-bordered table-hover dataTable no-footer">
                    <tr>
                        <td colspan=8>
                          <h3>Complementarios</h3>
                        </td>
                    </tr>
                    <tr>
                        <!--<td class="th1">&nbsp;</td>  -->
                        <td class="th1"><b>Contrato Complementario Nro.</b></td>
                        <td class="th1"><b>Item</b></td> 
                        <td class="th1"><b>Fecha de Renovacion</b></td>
                        <td class="th1"><b>Moneda</b></td>
                        <td class="th1"><b>Monto del Contrato Complementario</b></td>
                        <td class="th1"><b>Objeto del Contrato</b></td>
                        <td class="th1"><b>Plazo del Contrato Complementario</b></td>
                        <td class="th1"><b>Fecha de Culminacion del Contrato Complementario</b></td>
                    </tr>
                ');

            ------ Obtener la ultima fecha de Complementario ---------------
            select to_char(max(f_contrato), 'dd/mm/yyyy')
            into lv_fecmax_complem
            from REG_PROCESOS.convocatorias co, REG_PROCESOS.contrato c
            where co.n_convoca                   = c.n_convoca
              and c.n_convoca                    = ln_n_convoca
              and c.n_cod_contrato_de_renovac    = ln_cod_contrato
              and c.cod_operacion_contrato       = 6;

              for cc in c_complements(ln_n_convoca,ln_cod_contrato) loop
                begin
                    usp_print('<tr class="TabFilMan" align="center">');
         /* -- Se deshabilita por Memorando 1093-2014/SDP
                    if (lv_fecmax_complem!= cc.f_contrato) then
                        usp_print('<td></td>');
                    else
         */         usp_print('
                        <td align="left">
                          <b>'||makea('scriptdo=ManProrrogaDoEdit&ag_cod_operacion=6&ag_f_culminacion='||cc.f_culminacion||'&ag_ini_editar=1&ag_n_contrato='||cc.n_contrato||'&ag_n_convoca='||ln_n_convoca||'&ag_cod_contrato='||cc.n_cod_contrato||'&ag_cod_contrato_ren='||cc.n_cod_contrato_de_renovac,cc.n_contrato)||'</b>
                        </td>');
                        /*usp_print('
                            <td align="center">
                              '||REG_PROCESOS.PKU_XPORTAL_UTILS.UFUTIL_MKBTM('ManProrrogaDoEdit','Editar','Editar(this,'||ln_n_convoca||','||cc.n_cod_contrato||',')||'
                            </td>
                             ');*/
         --           end if;
                    usp_print('
                        <!--<td align="center">'||cc.n_contrato||'</td>-->
                        <td>'||PKU_GESTOR_CONT_UTILES_3.f_get_list_item_cont(cc.n_cod_contrato)||'</td>
                        <td>'||cc.f_contrato||'</td>
                        <td>'||cc.descripcion||'</td>
                        <td>'||cc.m_contratado||'</td>
                        <td>'||cc.des_contrato||'</td>
                        <td>'||cc.plazo||'</td>
                        <td>'||cc.f_culminacion||'</td>
                       </tr>
                        ');
                 end;
              end loop;
              usp_print('
                    </table>
                    <br/>
                    <br/>
                    ');
         end;
    end if;

   ---------- Java Script ---------------
    usp_print('
       <script language="javascript">
              function Editar(obj,nconvoca,codcontrato,objScrdo){
                thisform.ag_n_convoca.value=nconvoca;
                thisform.ag_cod_contrato.value=codcontrato;
                thisform.ag_ini_editar.value="1";
                thisform.scriptdo.value=objScrdo;
                thisform.submit();
                return true;
              }

     if (thisform.v_cantidad.value!= 0){
            alert("Complete las fechas de la vigencia del contrato.");
            }
             f_change_vigencia(thisform.v_cantidad.value);
       </script>
     ');

    exception
        when e_ArgumentosMalos then
            raise_application_error(-20000,'Se detecto una incorrecta asignacion de valores en los argumentos');

  End;


 ----------------------------------------------------------------------------------------------
 ---------------   uspNewProrrogaDoEdit -----------------
 ----------------------------------------------------------------------------------------------

PROCEDURE uspNewProrrogaDoEdit
     (
       ag_cod_operacion         varchar2,
       ag_des_causa_renov       varchar2,
       ag_plazo                 varchar2, -- Se agrega para que Plazo del Contrato Complementario no se pierda
       ag_f_contrato            varchar2,
       ag_f_culminacion         varchar2,
       ag_n_contrato            varchar2,
       ag_cm_opc                varchar2,
       ag_cm_oper_compra        varchar2,
       session__N_CONVOCA       varchar2 default null,
       session__COD_CONTRATO    varchar2 default null,
       ag_trama_items           varchar2 default null,
       ag_trama_calendario      VARCHAR2 DEFAULT NULL,
       session__anhoentidad     VARCHAR2 DEFAULT NULL,
       session__eue_codigo      VARCHAR2 DEFAULT NULL,
       SizeFile                 varchar2--aramirez

       ) Is

   ------- Variables ------
   e_ArgumentosMalos    exception;
   lv_eue_codigo        varchar2(20);
   lv_anhoentidad       varchar2(20);
   lv_procedure_main    varchar2(100);
   ln_n_convoca         number;
   lv_proc_sigla        varchar2(60);
   lv_proc_tipo_sigla   varchar2(60);
   lv_proc_num          varchar2(60);
   ln_proc_tipo         number;
   ln_n_proceso         number;
   ln_cod_contrato      number;
   ln_ind_siaf          number;
   lv_n_contrato        REG_PROCESOS.contrato.n_contrato%type;
   lv_ruc_contratista   REG_PROCESOS.contrato.ruc_contratista%type;
   lv_nom_contratista   REG_PROCESOS.contrato.nom_contratista%type;
   lv_f_contrato        varchar2(10);
   lv_des_contrato      REG_PROCESOS.contrato.des_contrato%type;
   lv_codmoneda_contrato REG_PROCESOS.contrato.des_contrato%type;
   lv_des_moneda        REG_PROCESOS.monedas.descripcion%type;
   lv_simbolo           REG_PROCESOS.monedas.simbolo%type;
   lv_f_contrato_pro    varchar2(10);
   lv_f_contrato_com    varchar2(10);
   lv_f_vigencia_fin    varchar2(10);
   ln_ncor_orden_pedido number;
   ln_CantItems_Cont    number;
   ln_monto_contr_orig  number;
   lv_codconsucode_paga varchar2(60);
   lv_anhoentidad_paga  varchar2(60);
   lv_ind_consorcio     varchar2(60);
   ln_codobjeto         NUMBER;
   lv_textoFormulario   varchar2(120);
   lv_textoFormulario2   varchar2(120);
   ln_cont_dias         NUMBER;

   coperacion           ref_cursor;

   lv_combo_operacion   varchar2(4000);
   ln_num_operaciones   number;

   lv_ruta_file                varchar2(300);


   --Aramirez
         lv_directorio            varchar2(50);  ---Aramirez
         lv_ruta                  varchar2(50); ---Aramirez
         /*lv_anhoentidad           varchar2(4); ---Aramirez
         lv_eue_codigo            varchar2(50); ---Aramirez*/

 BEGIN

 ---------------------------------------------------------------------------------------------------------
   lv_procedure_main   := 'NewProrrogaDoEdit';
   ln_cod_contrato     := to_number(session__cod_contrato);
   ln_n_convoca        := to_number(session__n_convoca);

   session_cod_contrato2 := ln_cod_contrato;
 ---------------------------------------------------------------------------------------------------------
   ln_codobjeto        := PKU_GESTOR_CONT_UTILES_3.f_getcodobjeto(session__N_CONVOCA);
   ln_cont_dias        := PKU_GESTOR_CONT_UTILES_3.f_getnumdiasoperaciones(session__COD_CONTRATO,ag_cod_operacion ) ;
   ln_num_operaciones  := PKU_GESTOR_CONT_UTILES_3.f_getnumoperaciones(session__COD_CONTRATO,ag_cod_operacion ) ;
   ln_ind_siaf         := PKU_GESTOR_CONT_UTILES_3.f_get_indSiaf(session__N_CONVOCA);

   coperacion          := PKU_GESTOR_CONT_UTILES_3.f_coperacionesAdenda(ln_codobjeto,ln_n_convoca);

   lv_combo_operacion  := PKU_GESTOR_CONT_UTILES_3.f_retorna_combo(coperacion, 'ag_cod_operacion', ag_cod_operacion,'Seleccione...','style="width:340px" onchange="CambioOperacion();"');

 -------- Funciones Script -----------------------------------------------------------------------------
    PKU_GESTOR_CONT_FUNCIONES_JS_3.sp_javascript_contratos;
    PKU_GESTOR_CONT_FUNCIONES_JS_3.fFechasGeneral;
    PKU_GESTOR_CONT_FUNCIONES_JS_3.fValidacionesGeneral;



    ---- aramirez inicio

   lv_anhoentidad := session__anhoentidad;
   lv_eue_codigo := session__eue_codigo;    
   lv_directorio := gpk_directorio_adicred;
   ---lv_ruta       := WriteFileDirectoryDynamic||'/'||docname;

   lv_ruta := lv_directorio||'\'||lv_anhoentidad||'\'||lpad(lv_eue_codigo,6,'0')||'\'||session__n_convoca; 

   usp_print('
     <input type ="hidden" name=WriteFileDirectoryDynamic value="'||lv_ruta||'" type=text>
     <input type ="hidden" name=WriteFileDirectory value="FileSinged" type=text>
     <input type="hidden" name="extension"/>
     <input type ="hidden" id=SizeFile name=SizeFile />
   ');

   -----aramirez FIN 


    usp_print('<script language="javascript">

    function cancelar(pagina)
       {
               thisform.scriptdo.value="LisProrrogasDoView";
               thisform.submit();
               return true;
        }

    function CambioOperacion()
          {
            thisform.ag_tipo_operacion.value = thisform.ag_cod_operacion.value;
            thisform.scriptdo.value = "NewProrrogaDoEdit";
            thisform.submit();
          }


    </script>
    ');

      ----- Obtener Datos de la Convocatoria-------
    if (ln_n_convoca is not null) then
        begin
           Select c.codconsucode,c.n_proceso,
                  c.anhoentidad,c.proc_tipo,c.proc_num,
                  c.proc_sigla,t.proc_tipo_sigla
           into   lv_eue_codigo,ln_n_proceso,
                  lv_anhoentidad,ln_proc_tipo,lv_proc_num,
                  lv_proc_sigla,lv_proc_tipo_sigla
           from REG_PROCESOS.convocatorias c,
                REG_PROCESOS.tipo_procesos t
           where t.proc_tipo =c.proc_tipo
             and c.n_convoca = ln_n_convoca;
          exception
             when no_data_found then
                  lv_eue_codigo:= null;
        end;
    else  --------- Convenio Marco -----------
        begin
           Select o.codconsucode,'' n_convoca,
                  o.anhoentidad,'' proc_tipo,'' proc_num,
                  '' proc_sigla,'' proc_tipo_sigla
           into   lv_eue_codigo,ln_n_convoca,
                  lv_anhoentidad,ln_proc_tipo,lv_proc_num,
                  lv_proc_sigla,lv_proc_tipo_sigla
           from reg_procesos.cm_orden_pedido o, REG_PROCESOS.contrato c
           where o.ncor_orden_pedido = c.ncor_orden_pedido
             and c.n_cod_contrato = ln_cod_contrato;
           exception
             when no_data_found then
                  lv_eue_codigo:= null;
        end;
    end if;

    ----- Obtener Datos del Contrato ----
    begin


      Select c.des_contrato,
          to_char(c.f_contrato, REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_fecha) f_contrato,
           c.n_contrato,
           c.ruc_contratista,
           c.nom_contratista,
           c.codmoneda_contrato,
           m.descripcion,
           m.simbolo,
           c.ncor_orden_pedido,
           to_char(c.f_vigencia_fin, REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_fecha),
           c.codconsucode_paga,
           c.anhoentidad_paga,
           c.m_contratado,
           c.ind_consorcio
      into lv_des_contrato,
           lv_f_contrato,
           lv_n_contrato,
           lv_ruc_contratista,
           lv_nom_contratista,
           lv_codmoneda_contrato,
           lv_des_moneda,
           lv_simbolo,
           ln_ncor_orden_pedido,
           lv_f_vigencia_fin,
           lv_codconsucode_paga,
           lv_anhoentidad_paga,
           ln_monto_contr_orig,
           lv_ind_consorcio
      from REG_PROCESOS.contrato c, reg_procesos.monedas m
     where c.codmoneda_contrato = m.codmoneda(+)
       and c.n_cod_contrato     = ln_cod_contrato;

    exception
         when no_data_found then
              lv_n_contrato:= null;
    end;


    -------- Fecha Maxima de Prorrogas -------
    select to_char(max(f_contrato), REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_fecha)
    into lv_f_contrato_pro
    from REG_PROCESOS.convocatorias co,
         REG_PROCESOS.contrato c
    where co.n_convoca                   = c.n_convoca
      and c.n_convoca                    = ln_n_convoca
      and c.n_cod_contrato_de_renovac    = ln_cod_contrato
      and c.cod_operacion_contrato       = 2;

    -------- Fecha Maxima de Complementarios -------
    select to_char(max(f_contrato), REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_fecha)
    into lv_f_contrato_com
    from REG_PROCESOS.convocatorias co,
         REG_PROCESOS.contrato c
    where co.n_convoca                   = c.n_convoca
      and c.n_convoca                    = ln_n_convoca
      and c.n_cod_contrato_de_renovac    = ln_cod_contrato
      and c.cod_operacion_contrato       = 6;


   --- Texto
   if (ag_cod_operacion = 2) then
     lv_textoFormulario := ' de la Prorroga';
      lv_textoFormulario2 := 'la Prorroga';
   elsif (ag_cod_operacion = 6) then
     lv_textoFormulario := ' del Contrato Complementario ';
     lv_textoFormulario2 := 'el Contrato Complementario';
   end if;


   -------- Titulos ------------

    usp_print('
    <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
        <tr>');
    usp_print(
            PKU_GESTOR_CONT_UTILES_3.f_get_titulo_contrato(session__COD_CONTRATO, 'Ingreso Prorrogas/Complementarios' )
    );

    usp_print('
            <td align="right" valign=top width="50%">
                <input type="button" value="Volver" OnClick="cancelar(''LisProrrogasDoView'')">
                <input type="button" value="Grabar" OnClick="grabar()">
                <input type="button" value="Seleccionar Items" OnClick="seleccionaritems()">
            </td>
         </tr>
    </table>
    <br>
       <input type="hidden" name="f_vigencia_actualizada"  id="f_vigencia_actualizada"   value="'||to_char(PKU_GESTOR_CONT_UTILES_3.f_get_fecha_fin_amp(ln_cod_contrato), 'dd/mm/yyyy')||'"/>
       <input type="hidden" name="ag_n_convoca"             value="'||ln_n_convoca||'"/>
       <input type="hidden" name="ag_cod_contrato"          value="'||ln_cod_contrato||'"/>
       <input type="hidden" name="ag_cod_contrato_ren"/>
       <input type="hidden" name="f_contrato_pen"           value="'||lv_f_contrato_pro||'"/>
       <input type="hidden" name="f_contrato_pencomp"       value="'||lv_f_contrato_com||'"/>
       <input type="hidden" name="f_contrato_ori"           value="'||lv_f_contrato||'"/>
       <input type="hidden" name="ag_ind_siaf"              value="'||ln_ind_siaf||'"/>
       <input type="hidden" name="ag_cod_presu" />
       <input type="hidden" name="ag_n_propuesta" />
       <input type="hidden" name="ag_num_pago" />
       <input type="hidden" name="ag_proc_item" />
       <input type="hidden" name="ag_fecha_pago" />
       <input type="hidden" name="ag_monto_pago" />
       <input type="hidden" name="ag_reg_cal_modif"         value=""/>
       <input type="hidden" name="ag_caditem_item"          value=""/>
       <input type="hidden" name="ag_caditem_unid"          value=""/>
       <input type="hidden" name="ag_caditem_cant"          value=""/>
       <input type="hidden" name="ag_caditem_monto"         value=""/>
       <input type="hidden" name="ag_tipo_operacion"        value="">
       <input type="hidden" name="ag_codconsucode"          value="'||lv_eue_codigo||'" />
       <input type="hidden" name="ag_anhoentidad"           value="'||lv_anhoentidad||'" />
       <input type="hidden" name="ag_ncor_orden_pedido"     value="'||ln_ncor_orden_pedido||'" />
       <input type="hidden" name="ag_cm_opc"                value="'||ag_cm_opc||'" />
       <input type="hidden" name="ag_cm_oper_compra"        value="'||ag_cm_oper_compra||'" />
       <input type="hidden" name="ag_cant_items"            value="'||ln_CantItems_Cont||'" />
       <input type="hidden" name="ag_next_url"              value="'||lv_procedure_main||'" />
       <input type="hidden" name="ag_tipo_op"               value="1" />
       <input type="hidden" name="ag_codconsucode_paga"     value="'||lv_codconsucode_paga||'" />
       <input type="hidden" name="ag_anhoentidad_paga"      value="'||lv_anhoentidad_paga||'" />
       <input type="hidden" name="monto_contr_orig"         value="'||ln_monto_contr_orig||'"/>
       <input type="hidden" name="ag_ruc_contratista"       value="'||lv_ruc_contratista||'" />
       <input type="hidden" name="ag_ind_consorcio"         value="'||lv_ind_consorcio||'" />
       <input type="hidden" name="ag_back_page"             value="'||lv_procedure_main||'" />
       <input type="hidden" name="proc_item"                value="" />
       <input type="hidden"  name="ag_pagina_retorno"        value="NewProrrogaDoEdit"/>
       <input type="hidden" name="ag_proc_tipo"   id="ag_proc_tipo"             value="'||ln_proc_tipo||'" />


       <input type="hidden" name="ag_f_vigencia_fin"        value="'||lv_f_vigencia_fin||'" />
       <input type="hidden" name="ag_cont_dias"             value="'||ln_cont_dias||'" />
       <input type="hidden" name="ag_trama_items"           value="" />
       ');

    lv_ruta_file      := 'mon\docs\contratos'||'\'||session__anhoentidad||'\'||session__eue_codigo||'\';

  --  usp_print('<input type="hidden" name="WriteFileDirectory"          value="FileSinged">');
  --  usp_print('<input type="hidden" name="WriteFileDirectoryDynamic"   value="'||lv_ruta_file||'"></input>');

   -- para calcular si las cantidades son iguales
   usp_print('
         <input type ="hidden" name="an_total_items"           value=""/>
         <input type ="hidden" name="an_total_calendario"      value=""/>');

   ------- Numero del Contrato --------
    usp_print('
    <h3>Datos Generales</h3>
    <table style="width:100%" class="table table-striped">
    <tr>
        <td style="width:33%">(*)N&uacute;mero del Contrato Original</td>
        <td style="width:33%" ><b>'||session__COD_CONTRATO||'</b></td>
        <td style="width:34%" >Numero del Contrato</td>
    </tr>
    <tr>
          <td>(*)Tipo operacion del Contrato Original</td>
          <td>'||lv_combo_operacion||'</td>
          <td>Seleccione el Tipo de Operacion a Realizar</td>
    </tr>');

   IF ag_cod_operacion IS NULL THEN
      USP_PRINT('</table>');
      RETURN;
   ELSIF ag_cod_operacion = 6 AND ln_num_operaciones > 0 THEN
      usp_print('</table>');
      USP_PRINT('<h3><center>Ya se ha registrado Contrato Complementario para todos los items</center></h3></br>');
      RETURN;
   END IF;

   usp_print('
        <tr>
            <td class=c1>(*)Objeto '||lv_textoFormulario||'</td>
            <td class=c2>
                <input type=text name="ag_des_contrato" value="'||lv_des_contrato||'" size=54>
            </td>
            <td class=c3>Descripcion '||lv_textoFormulario||'</td>
        </tr>
        <tr>
            <td class=c1>(*)Numero '||lv_textoFormulario||'</td>
            <td class=c2><input name="ag_n_contrato" value="'||ag_n_contrato||'" size=54 class="form-control"></td>
            <td class=c3>Ingrese el Numero '||lv_textoFormulario||'</td>
        </tr>
        <tr>
            <td class=c1>(*)Fecha '||lv_textoFormulario||'</td>
            <td class=c2>
              <div class="input-group datepicker" >

               <input type="text" name="ag_f_contrato" onblur="thisform.ag_plazo.value= diasEntre(thisform.f_vigencia_actualizada.value,thisform.ag_f_culminacion.value);validar_rnp(this);" value="'||ag_f_contrato||'" style="width:98%" data-format="dd/MM/yyyy" class="form-control add-on"/>
          </div>  
            </td>
            <td class=c3>Ingrese la Fecha '||lv_textoFormulario||'</td>
        </tr>
        <tr>
            <td class=c1>(*)Fecha de Culminacion '||lv_textoFormulario||'</td>
            <td class=c2>
            <div class="input-group datepicker" >
               <input type="text" name="ag_f_culminacion" onblur="thisform.ag_plazo.value= diasEntre(thisform.f_vigencia_actualizada.value,thisform.ag_f_culminacion.value)" value="'||ag_f_culminacion||'" style="width:98%" data-format="dd/MM/yyyy" class="form-control add-on"/>
          </div> 
            </td>
            <td class=c3>Ingrese la Fecha de Culminacion '||lv_textoFormulario||'</td>
        </tr>
        <tr>
            <td class=c1>(*)Justificaci&oacute;n '||lv_textoFormulario||'</td>
            <td class=c2>
                <input type=text name="ag_des_causa_renov" size=54 value="'||ag_des_causa_renov||'">
            </td>
            <td class=c3>Ingrese la Causa '||lv_textoFormulario||'</td>
        </tr>
        <tr>
            <td class=c1>Moneda</td>
            <td class=c2>
                <b>'||lv_des_moneda||'</b>
                <input name="ag_cod_moneda" type="hidden" value="'||lv_codmoneda_contrato||'" />
            </td>
            <td class=c3>Moneda del Contrato Original</td>
        </tr>
        <tr>
            <td class=c1>Monto del contrato Original</td>
            <td class=c2>
                <b>'||ln_monto_contr_orig||'</b>
                <input name="monto_origen" type="hidden" value="'||ln_monto_contr_orig||'" />
            </td>
            <td class=c3>Moneda del Contrato Original</td>
        </tr>
        <tr>
            <td class=c1>(*)Monto  '||lv_textoFormulario||'</td>
            <td class=c2><input name="ag_monto_adicional" value="" readOnly="true" maxlength="11" size=54 class="form-control"/></td>
            <td class=c3>Monto del Contrato</td>
        </tr>
        <tr>
            <td class=c1>(*)Plazo '||lv_textoFormulario||'</td>');
       usp_print('
            <td class=c2><input name="ag_plazo" value="'||ag_plazo||'" readOnly="true" maxlength="11" size=54 class="form-control"/></td>
            <td class=c3>Ingrese el Plazo '||lv_textoFormulario||'</td>
        </tr>
      <!--  <tr>
           <td align="left"><font color="green">
                <b>(El Monto Contratado es '||lv_simbolo||'  '||to_char(ln_monto_contr_orig,REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_dinero)||' -
                    La Vigencia del Contrato es hasta el '||lv_f_vigencia_fin||')</b></font>
           </td>
        </tr> -->');



 /* usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Adjunte archivo '||lv_textoFormulario,
                '<input type="file"  name="pfiletoupload" size="41"  value="">',
                'Seleccione el archivo que contiene el Contrato Complementario. S&oacute;lo archivos tipo doc, pdf y zip'));*/

     usp_print('
        <script language="javascript">
            function obtenerTamano(){
                var x = document.getElementById(''pfiletoupload1'');
                var file_size_final;
                if (''files'' in x) {
                     if (x.files.length == 0) {
                     }else{
                        var file = x.files[0];
                        //alert(file.size);
                        file_size_final=file.size; 
                        var xfile = document.getElementById(''SizeFile'');
                        xfile.value=file_size_final;
                        //alert(file_size_final);
                     }                    
                }            
            }
        </script>');               


    usp_print(            
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Adjunte archivo'||lv_textoFormulario||'',
                '<input type="file" id="pfiletoupload1"  name="pfiletoupload1" class="form-control" size="'|| SizeFile|| '" value="" onchange="obtenerTamano()">
                <input type="hidden" name="pfiletoupload_file1" value=""/>',
                  'Seleccione el archivo  que contiene '||lv_textoFormulario2||'. SÃ³lo archivos tipo doc,pdf y zip'));    

      usp_print('</table>
      <br>
        ');


  IF (ln_ind_siaf = 1) THEN
         usp_print('
         <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
            <tr>
                <td><h3>(*)Calendario</h3></td>
            <tr aling=center>
                <td>');
          PKU_GESTOR_CONT_FUNCIONES_JS_3.fXmlCalendario(lv_codmoneda_contrato , ag_trama_calendario, 'an_total_calendario');
          usp_print('</td>
                </tr>
            </table>
            <br>
            <br>'
            );

  END IF;

  ----------------- items --------------------------------

  IF ag_trama_items IS NOT NULL THEN

  usp_print('<tr><td><h3>Items</h3></td></tr>');
  usp_print('<tr align=center>');
  usp_print('<TD colspan="4" align=center>');
  PKU_GESTOR_CONT_FUNCIONES_JS_3.fXmlItemsReader(ag_trama_items,'an_total_items');
  usp_print('</TD></TR>');

  END IF;

 ----------------- Java Script --------------
 usp_print('
 <script language="javascript">

  function seleccionaritems(){
  try{
    xmlDelEliminar($("#xmlCalendario").html());
    thisform.ag_trama_calendario.value = $("#xmlCalendario").html();
/*  xmlDelEliminar(xmlCalendario);
    thisform.ag_trama_calendario.value = xmlCalendario.xml;*/
    }catch(err){}
    thisform.scriptdo.value="NewProItemDoEdit";
    thisform.submit();
  }

 function validarFechaMonto()
     {
        var dif_dias;

        if(ValidarBlanco(thisform.ag_f_contrato,"la Fecha de la Prorroga o Contrato Complementario") && ValidarBlanco(thisform.ag_f_culminacion,"la Fecha de Culminacion de la Prorroga o Contrato Complementario"))
        {
             if(thisform.ag_f_contrato.value == thisform.ag_f_culminacion.value){
                  alert("La fecha de la prorroga o Contrato Complementario y la fecha de culminacion no pueden ser iguales")
                  thisform.ag_f_contrato.focus();
                  return false;
             }
        }
        else {
                return false;
        }

        // Validar Prorroga
        /*if(thisform.ag_cod_operacion.value==2){
               if (parseFloat(thisform.ag_cont_dias.value) + parseFloat(thisform.ag_plazo.value) > 360){
                  alert("Solo se pueden realizar prorrogas por un maximo de 3 a?os");
                  return false;
               }
          }*/

        // Validar Complementario
        if(thisform.ag_cod_operacion.value==6){
             dif_dias    = diasEntre(thisform.ag_f_vigencia_fin.value,thisform.ag_f_contrato.value);

             if (dif_dias <= 0) {
                alert("La fecha del Contrato Complementario, debe ser posterior al fin de vigencia del Contrato")
                return false;
              }
            /* if (dif_dias > 0 && dif_dias > 90 ){
                alert("El contrato complementario se debe realizar dentro de los tres meses posteriores a la culminacion del Contrato")
                return false;
              }*/
        }
        return true;
    }

  function validarMonto(){

      if (thisform.ag_ind_siaf.value == 1){
         if(thisform.an_total_calendario.value == 0 ){
              alert("Debe registrar el cronograma de pagos");
              thisform.ag_cal_monto_pago.focus();
              return false;
         }
      }

      if(thisform.an_total_items.value == ""){
              alert("Debe seleccionar al menos un item para continuar");
              return false;
      }

      if (redondear(thisform.an_total_calendario.value,2) !=  redondear(thisform.an_total_items.value,2)){
          alert("La suma de los montos en el Calendario de pago no coincide con el monto contratado, corrija e intente nuevamente")
          //thisform.ag_cal_monto_pago.focus();
          return false;
        }

         return true;
  }

  function generacionTramaCalendario(){
        var xmlCalendario = "";
        xmlCalendario = xmlCalendario+"<root>";
        $(".cFilaCalendario").each(function(){
        xmlCalendario = xmlCalendario+"<calendario>"+
        "<fecha>"+$(this).children().eq(''1'').children().children(''.fecCalendar'').val()+"</fecha>"+
        "<monto>"+$(this).children().eq(''2'').children().val()+"</monto>"+         
        "<control></control>"+                  
        "<id></id>"+         
        "<moneda></moneda>"+
        "<numpago>"+$(this).children().eq(''0'').text()+"</numpago>"+
                      "</calendario>"    
       });
       xmlCalendario = xmlCalendario+"</root>";  
       thisform.ag_trama_calendario.value = xmlCalendario;
     }

  function grabar()
  {
      alert("Debe recordar que los contratos de  arrendamiento de \nbienes inmuebles, el plazo maximo de duracion del \ncontrato son diez (10) a?os y en el caso que el bien \narrendado pertenezca a entidades publicas seis (6) a?os.  ")

      if (!ValidarBlanco(thisform.ag_n_contrato,"Numero del Contrato Complementario o Prorroga")){
            return false;
       }

      if (!ValidarBlanco(thisform.ag_des_contrato,"la Descripcion del Contrato Complementario o Prorroga")){
            return false;
       }

      if (!ValidarBlanco(thisform.ag_des_causa_renov,"la Causa del Contrato Complementario o Prorroga")){
            return false;
       }

       /*aramirez  INICIO*/

if (thisform.pfiletoupload1.value != "" )
  {
            var x = document.getElementById(''pfiletoupload1'');
                var file_size_final;
                if (''files'' in x) {
                     if (x.files.length == 0) {
                     }else{
                        var file = x.files[0];
                        //alert(file.size);
                        file_size_final=file.size; 
                        var xfile = document.getElementById(''SizeFile'');
                        xfile.value=file_size_final;
                      // alert(file_size_final);
                      // return false;
                     }                    
                }  

            var tamarchivo=parseFloat(file_size_final);
         var varcomparar=367001600;

         if(file_size_final>=varcomparar)
           {
               alert("Registre un archivo menor a 350 MB");
               return false;
           }



		var extension = thisform.pfiletoupload1.value.substring(thisform.pfiletoupload1.value.length-4);

		//extension = extension.replace(".","");



		if (extension == "docx")
                        {
                            extension = "." + extension;

                        }
		if ( extension == ".doc" || extension == ".pdf" || extension == ".zip" || extension == ".rar" || extension == ".docx")
					{


						var namearchive = "'||to_char(sysdate, 'ddmmyyyyHH24MISS')||'"+extension;
						thisform.pfiletoupload_file1.value = namearchive;
						thisform.extension.value = extension;
					}

			else
					{
						alert("Registre archivos con extensión doc, docx, pdf, zip o rar");
						return false ;
					}
  }

		else 	{
					alert ("Registre el documento ");
				return false ;
				}



/*aramirez  FIN*/




     ');

    IF (ln_ind_siaf = 1) THEN
        usp_print('
              if(!validarMonto()){ return false; }');
    END IF;

    usp_print('

      if(!validarFechaMonto())
      {
         return false;  }
     ');

   /* usp_print('
            thisform.ag_trama_items.value = xmlItems.xml;

    ');*/
    IF (ln_ind_siaf = 1) THEN
        usp_print('
        //thisform.ag_trama_calendario.value = xmlCalendario.xml; 
        generacionTramaCalendario();');
    END IF;

    usp_print('
            thisform.ag_cod_contrato_ren.value=thisform.ag_cod_contrato.value;
            thisform.scriptdo.value="ProrrogaDoInsert";
            thisform.submit();
            return true;
        }



        function validar_rnp(obj)
        {
          if(thisform.ag_cod_operacion.value==6)
          {
             thisform.scriptdo.value="ValRNPProrrogaDoView";
             thisform.submit();
          }
          return true;
        }


       </script>
     ');

     usp_print('<script language="javascript">
     $(document).ready(function(){
     try{
 //      thisform.ag_monto_adicional.value= redondear(parseFloat(sumaTotalesItems(xmlItems)),2);
         if(!isNaN(parseFloat(thisform.an_total_items.value))){
            thisform.ag_monto_adicional.value= redondear(parseFloat(thisform.an_total_items.value),2);                                
         }else{
            thisform.ag_monto_adicional.value= 0;                                         
         }
      }catch(err){
      }
      });
     </script>');


  End;




    /********************************************************************/
      PROCEDURE uspProrrogaDoInsert
     ( ag_id_usuario                varchar2,
       ag_n_convoca                 varchar2,
       ag_cod_contrato_ren          varchar2,
       ag_n_contrato                varchar2,
       ag_cod_moneda                varchar2,
       ag_f_contrato                varchar2,
       ag_monto_adicional           varchar2,
       ag_des_causa_renov           varchar2,
       ag_des_contrato              varchar2,
       ag_plazo                     varchar2,
       ag_f_culminacion             varchar2,
       ag_codconsucode              varchar2,
       ag_anhoentidad               varchar2,
       ag_cod_operacion             varchar2,
       ag_ncor_orden_pedido         varchar2,
       ag_ind_siaf                  varchar2,
       ag_codconsucode_paga         varchar2,
       ag_anhoentidad_paga          varchar2,
       ag_ind_consorcio             varchar2,
       ag_ruc_contratista           varchar2,
       session__N_CONVOCA           VARCHAR2,
       ag_trama_calendario          varchar2,
       ag_trama_items               varchar2,
       pfiletoupload_file1             VARCHAR2,--aramirez
       session__eue_codigo            VARCHAR2 DEFAULT NULL ,--aramirez
       ag_fec_doc_adicional           VARCHAR2,--aramirez
       SizeFile                        varchar2,--aramirez
       session__COD_CONTRATO        varchar2 default null,
       ag_proc_tipo                 varchar2,
       session__USERID                 VARCHAR2, --aramirez
       iisenv__remote_host             VARCHAR2,--aramirez
       WriteFileDirectoryDynamic       VARCHAR2 --aramirez
       ) Is

   ----------- Variables ---------
   ln_cod_contrato_ren     number:= null;
   ln_cod_contrato         number:= null;
   ln_n_convoca            number:= null;
   ln_n_convoca_max        number:= null;
   ln_codobjeto            number:= null;
   ln_cod_moneda           number:= null;
   ln_ind_siaf             number:= null;
   ld_f_contrato           date:= null;
   ln_m_contratado         number:= null;
   lv_des_causa_renov      varchar2(1000):= null;
   lv_des_contrato         varchar2(500):= null;
   ln_plazo                number:= null;
   ld_f_culminacion        date:= null;
   lv_codconsucode         varchar2(6):= null;
   lv_anhoentidad          varchar2(4):= null;
   ln_cod_operacion_cont   number:= null;
   ls_result_valrnp        varchar2(2000);
   ln_valida_rango         number;

   lb_validacion_rnp               BOOLEAN;
   lv_estado_rnp                   VARCHAR2(500);


    --ARAMIREZ

         lv_directorio            varchar2(50);  -----ARAMIREZ
         lv_ruta                  varchar2(50); -----ARAMIREZ
         --lv_anhoentidad           varchar2(4); -----ARAMIREZ
         lv_eue_codigo            varchar2(50); -----ARAMIREZ
         lv_codtipofile           VARCHAR2(20);-----ARAMIREZ
         lv_id_redu                 NUMBER ;    -----ARAMIREZ



   Begin

     ln_n_convoca          := to_number(ag_n_convoca);
     ln_cod_contrato_ren   := to_number(ag_cod_contrato_ren);

     if (ag_cod_moneda is not null) then  ln_cod_moneda:= to_number(ag_cod_moneda);  end if;
     if (ag_ind_siaf is not null) then ln_ind_siaf:= to_number(ag_ind_siaf);  end if;
     ---if (ag_monto_adicional is not null) then ln_m_contratado:= nvl(round(TO_NUMBER (ag_monto_adicional),2),0); end if;
     if (ag_monto_adicional is not null) then ln_m_contratado:= nvl(round(TO_NUMBER(ag_monto_adicional,'999999999999999999999.99',' NLS_NUMERIC_CHARACTERS = '',.'''),2),0); end if;  ---jgarciaf 08062020
     if (ag_des_causa_renov is not null) then lv_des_causa_renov:= trim(ag_des_causa_renov);   end if;
     if (ag_des_contrato is not null) then    lv_des_contrato:= trim(ag_des_contrato);   end if;
     if (ag_plazo is not null) then ln_plazo:= to_number(ag_plazo); end if;
     if (ag_f_contrato is not null) then ld_f_contrato:= to_date(ag_f_contrato,REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_fecha);      end if;
     if (ag_f_culminacion is not null) then ld_f_culminacion:= to_date(ag_f_culminacion,REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_fecha);  end if;
     if (ag_codconsucode is not null) then lv_codconsucode:= trim(ag_codconsucode); end if;
     if (ag_anhoentidad is not null) then lv_anhoentidad:= trim(ag_anhoentidad); end if;
     if (ag_cod_operacion is not null) then ln_cod_operacion_cont:= to_number(ag_cod_operacion); end if;

     -------------------- Hiddens ----------------------
     usp_print('
        <input type="hidden"  name ="ag_n_contrato"                     value="'||ag_n_contrato||'" />
        <input type="hidden"  name ="ag_cod_moneda"                     value="'||ag_cod_moneda||'" />
        <input type="hidden"  name ="ag_codmoneda_contrato"             value="'||ag_cod_moneda||'" />
        <input type="hidden"  name ="ag_des_causa_renov"                value="'||ag_des_causa_renov||'" />
        <input type="hidden"  name ="ag_des_contrato"                   value="'||ag_des_contrato||'" />
        <input type="hidden"  name ="ag_plazo"                          value="'||ag_plazo||'" />
        <input type="hidden"  name ="ag_f_culminacion"                  value="'||ag_f_culminacion||'" />
        <input type="hidden"  name ="ag_f_contrato"                     value="'||ag_f_contrato||'" />
        <input type="hidden"  name ="ag_cod_operacion"                  value="'||ag_cod_operacion||'" />
        <input type="hidden"  name ="ag_cod_contrato_ren"               value="'||ag_cod_contrato_ren||'" />
        <input type="hidden"  name ="ag_id_usuario"                     value="'||ag_id_usuario||'" />
        <input type="hidden"  name ="ag_n_convoca"                      value="'||ag_n_convoca||'" />
        <input type="hidden"  name ="ag_cod_contrato"                   value="'||ag_cod_contrato_ren||'" />
        <input type="hidden"  name ="ag_monto_adicional"                value="'||ag_monto_adicional||'" />
        <input type="hidden"  name ="ag_ncor_orden_pedido"              value="'||ag_ncor_orden_pedido||'" />
        <input type="hidden"  name ="ag_cm_opc" />
        <input type="hidden"  name ="ag_cm_oper_compra" />
        ');

     -------------------- Validar Vigencia del Contrato  ------------------------------
     IF (ln_cod_operacion_cont = 2) THEN --- Prorroga ---

        select count(1) into  ln_valida_rango
          from reg_procesos.contrato x
         where x.n_cod_contrato = session__COD_CONTRATO
           and trunc(to_date(ag_f_contrato,'dd/mm/yyyy')) >= trunc(x.f_vigencia_ini)
           and trunc(to_date(ag_f_contrato,'dd/mm/yyyy')) <= trunc(PKU_GESTOR_CONT_UTILES_3.f_get_fecha_fin_amp(session__COD_CONTRATO))
           ;
/*
        IF ln_valida_rango = 0  THEN

              usp_print(
              pku_procesos_comun.f_putMensaje(
                  'La fecha de la Prorroga se debe encontrar dentro de la vigencia del contrato.',
                  '')
          );
          RETURN;
        END IF;
*/
     ELSIF(ln_cod_operacion_cont = 6) THEN --- Complementario


      select count(1) into  ln_valida_rango
          from reg_procesos.contrato x
         where x.n_cod_contrato = session__COD_CONTRATO
           and trunc(to_date(ag_f_contrato,'dd/mm/yyyy')) > trunc(PKU_GESTOR_CONT_UTILES_3.f_get_fecha_fin_amp(session__COD_CONTRATO))
           and trunc(to_date(ag_f_contrato,'dd/mm/yyyy')) <= add_MONTHS(trunc(PKU_GESTOR_CONT_UTILES_3.f_get_fecha_fin_amp(session__COD_CONTRATO)),3)
           ;

        -- Memop 368 -2011 - spla-raaa
        IF ln_valida_rango = 0 and ag_proc_tipo not in (11,23) THEN

              usp_print(
              pku_procesos_comun.f_putMensaje(
                  'El contrato complementario se debe realizar dentro de los tres meses posteriores a la culminacion del Contrato.',
                  '')
          );
          RETURN;
        END IF;

     END IF;

  /*   -------------------- Validar Vigencia RNP ------------------------------
     if (ln_cod_operacion_cont = 6) then --- Complementario---
         if (ag_n_convoca is not null ) then

           if ( substr(ag_ruc_contratista,1,1) not in ('7','I')  /*or ln_proc_tipo <> 23 )then

                lb_validacion_rnp := reg_procesos.pku_ss_mod_contratos.F_VALIDA_RNP_CONTRATO(ag_ruc_contratista, ag_n_convoca,ag_f_contrato, lv_estado_rnp);


                IF NOT lb_validacion_rnp THEN
                   reg_procesos.pku_ss_mod_contratos.f_msg_pantalla(lv_estado_rnp,'''NewProrrogaDoEdit''');
                   reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_3.js_script(' _error = 1; ');
                   return;
                END IF;

            END IF;
          --   ls_result_valrnp:= reg_procesos.F_VALIDA_CONT_RNP(ag_n_convoca, ag_ind_consorcio,ag_ruc_contratista,null, ag_f_contrato);

             if (ls_result_valrnp is not null) then
                 if (substr(ls_result_valrnp,1,1) != 1) then -- RUC No esta Vigente ---
                     begin
                           usp_print('
                           <script language=javascript>
                             alert("El Proveedor no cuenta con inscripcion vigente en el RNP \n       o esta inhabilitado para contratar con el estado");
                             thisform.scriptdo.value = "NewProrrogaDoEdit";
                             thisform.submit();
                           </script>
                           ');
                           return;
                     end;
                 end if;
             end if;
         end if;
     end if;*/


    -- select * into consucode2,proveedor2,proceso2,nconvoca2,fcontra2,npropuesta2 from table(f_get_emp_dets(session_cod_contrato2));

         if (consucode2='002433' and proceso2='SEL') or (consucode2='002433' and proceso2='ABR') or (consucode2='002433' and proceso2='COM') then

                   lb_validacion_rnp3 := f_valida_rnp_contrato(proveedor2,nconvoca2,ag_f_contrato,npropuesta2,lb_estado_inha2);
                      if  lb_validacion_rnp3 then
                                                       ---empieza aqui
                         ---------- Obtiene nuevo codigo de Contrato --------
                         SELECT REG_PROCESOS.s_contrato.NEXTVAL INTO ln_cod_contrato FROM dual;

                         ---------- Obtiene maximo numero de Convocatoria --------
                         SELECT REG_PROCESOS.f_get_max_n_convoca( ln_n_convoca ) INTO ln_n_convoca_max FROM dual;

                         ---------- Obtiene el codigo de objeto de la convocatoria --------
                         SELECT codobjeto INTO ln_codobjeto FROM REG_PROCESOS.convocatorias WHERE n_convoca = ln_n_convoca;





         ------------------------- Obtiene el tipo de archivo ARAMIREZ -------------------------------------

   BEGIN
        --select cod_tipo_file into lv_codtipofile From Reg_procesos.tipo_archivo Where ext_tipo_file=upper(substr(pfiletoupload_file1,length(pfiletoupload_file1)-2,length(pfiletoupload_file1)));
        select cod_tipo_file into lv_codtipofile From Reg_procesos.tipo_archivo Where ext_tipo_file=upper(substr(pfiletoupload_file1,(INSTR(pfiletoupload_file1,'.',1) + 1)));
   EXCEPTION
   WHEN OTHERS THEN
          usp_print(
                pku_procesos_comun.f_putMensaje(
                    'Error: Al intentar registrar el archivo.',
                    '')
            );
           return;
   END;

   ------------------------- Fin de Obtiene el tipo de archivo  ARAMIREZ------------------------------
                                  ---------- Grabar Nuevo Contrato -----------

                         insert into REG_PROCESOS.contrato
                         (  n_cod_contrato, n_contrato, n_cod_contrato_de_renovac,
                            n_convoca, f_contrato, m_contratado, codmoneda_contrato,
                            des_causa_renovacion, des_contrato, plazo, f_culminacion,
                            codconsucode, anhoentidad,cod_operacion_contrato,
                            codconsucode_paga, anhoentidad_paga
                         ) values
                         (
                           ln_cod_contrato, ag_n_contrato, ln_cod_contrato_ren,
                           ln_n_convoca, ld_f_contrato, ln_m_contratado, ln_cod_moneda,
                           lv_des_causa_renov, lv_des_contrato, ln_plazo, ld_f_culminacion,
                           lv_codconsucode, lv_anhoentidad,ln_cod_operacion_cont,
                           ag_codconsucode_paga, ag_anhoentidad_paga
                         );

                         ---------- Insertar Items Prorrogados --------
                         usp_registra_items(ag_trama_items,ln_cod_contrato,ln_n_convoca);

                        ---------- Grabar Calendario de Pagos ----------
                        if ln_ind_siaf = 1 then
                         usp_registra_calendario(ag_trama_calendario);
                        end if;
                        ----------- Actualiza la Ultima Operacion del Contrato ----

                        update REG_PROCESOS.contrato  set
                               ID_OPERACION = REG_PROCESOS.PK_CONVOCATORIA.getidoperacion()
                        where n_cod_contrato = ln_cod_contrato;

                        ----------- Actualiza el Costo Final ---------
                        reg_procesos.pku_ss_make_contrato.usp_calcula_costoFinal(ln_cod_contrato_ren);

                        ----------- Transfiere al MEF ------------
                        ----------- Si es complementario se transfiere al MEF -----------
                    --    if (ln_cod_operacion_cont = 6) then
                    --        REG_PROCESOS.PK_TRANS_MEF.SP_WS_MEF_SEND_OPERACION(REG_PROCESOS.PK_CONVOCATORIA.getidoperacion());
                    --    elsif (ln_codobjeto != 1) then
                        ----------- Si es Prorroga y el objeto no es Bienes se transfiere al MEF -----------
                            REG_PROCESOS.PK_TRANS_MEF.SP_WS_MEF_SEND_OPERACION(REG_PROCESOS.PK_CONVOCATORIA.getidoperacion());
                    --    end if;

   ---- aramirez inicio

   lv_anhoentidad := ag_anhoentidad;
   lv_eue_codigo := session__eue_codigo;    
   lv_directorio := gpk_directorio_adicred;
   lv_ruta := lv_directorio||'\'||lv_anhoentidad||'\'||lpad(lv_eue_codigo,6,'0')||'\'||ag_n_convoca; 

   usp_print('
     <input type ="hidden" name=WriteFileDirectoryDynamic value="'||lv_ruta||'" type=text>
     <input type ="hidden" name=WriteFileDirectory value="FileSinged" type=text>
   ');



     BEGIN

            select max(N_COD_CONTRATO) into lv_id_redu from REG_PROCESOS.contrato where n_cod_contrato=ln_cod_contrato;

            if ln_cod_operacion_cont=2 then

        REG_PROCESOS.PKU_GESTOR_CONT_UTILES_2.p_insUploadprorroga(
              reg_procesos.f_get_min_n_convoca(session__N_CONVOCA),
              TO_DATE (ag_fec_doc_adicional,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
              'NULL',--doc_obs,
              lv_codtipofile,
              pfiletoupload_file1,
              SizeFile,
              session__userid,
              iisenv__remote_host,
              WriteFileDirectoryDynamic,
              ln_cod_contrato,
              lv_id_redu);

           ELSIF ln_cod_operacion_cont=6 then   

              REG_PROCESOS.PKU_GESTOR_CONT_UTILES_2.p_insUploadComplementario(
              reg_procesos.f_get_min_n_convoca(session__N_CONVOCA),
              TO_DATE (ag_fec_doc_adicional,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
              'NULL',--doc_obs,
              lv_codtipofile,
              pfiletoupload_file1,
              SizeFile,
              session__userid,
              iisenv__remote_host,
              WriteFileDirectoryDynamic,
              ln_cod_contrato,
              lv_id_redu);

              end if;

   EXCEPTION
      WHEN OTHERS THEN
          usp_print(
                pku_procesos_comun.f_putMensaje(
                    'Error: Al intentar registrar el Documento.',
                    '')
            );
           return;

   END;

----- aramirez fin                    

                        commit;


                        usp_print('
                        <script language=javascript>
                           thisform.scriptdo.value="LisProrrogasDoView";
                           thisform.submit();
                        </script>
                        ');
                       ---termina aqui
                       else 
                           begin   

                                 if lb_error2 then
                                       usp_print('
                                   <script language=javascript>
                                    alert("Sistema externo no disponible, vuelva a intentar");
                                     thisform.scriptdo.value = "NewProrrogaDoEdit";
                                     thisform.submit();
                                   </script>
                                   ');
                                   return;

                                 else

                                   usp_print('
                                   <script language=javascript>
                                     alert("El proveedor'||' '|| proveedor2 ||' '||'se encuentra inhabilitado, no es posible publicar el contrato");
                                     thisform.scriptdo.value = "NewProrrogaDoEdit";
                                     thisform.submit();
                                   </script>
                                   ');
                                   return;

                                   end if;
                             end;
                        end if;

             else 



              -------------------- Validar Vigencia RNP ------------------------------
     if (ln_cod_operacion_cont = 6) then --- Complementario---
         if (ag_n_convoca is not null ) then

           if ( substr(ag_ruc_contratista,1,1) not in ('7','I')  /*or ln_proc_tipo <> 23*/ )then

                lb_validacion_rnp := reg_procesos.pku_ss_mod_contratos.F_VALIDA_RNP_CONTRATO(ag_ruc_contratista, ag_n_convoca,ag_f_contrato, lv_estado_rnp);


                IF NOT lb_validacion_rnp THEN
                   reg_procesos.pku_ss_mod_contratos.f_msg_pantalla(lv_estado_rnp,'''NewProrrogaDoEdit''');
                   reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_3.js_script(' _error = 1; ');
                   return;
                END IF;

            END IF;
          --   ls_result_valrnp:= reg_procesos.F_VALIDA_CONT_RNP(ag_n_convoca, ag_ind_consorcio,ag_ruc_contratista,null, ag_f_contrato);

             if (ls_result_valrnp is not null) then
                 if (substr(ls_result_valrnp,1,1) != 1) then -- RUC No esta Vigente ---
                     begin
                           usp_print('
                           <script language=javascript>
                             alert("El Proveedor no cuenta con inscripcion vigente en el RNP \n       o esta inhabilitado para contratar con el estado");
                             thisform.scriptdo.value = "NewProrrogaDoEdit";
                             thisform.submit();
                           </script>
                           ');
                           return;
                     end;
                 end if;
             end if;
         end if;
     end if;




   ---empieza aqui
     ---------- Obtiene nuevo codigo de Contrato --------
     SELECT REG_PROCESOS.s_contrato.NEXTVAL INTO ln_cod_contrato FROM dual;

     ---------- Obtiene maximo numero de Convocatoria --------
     SELECT REG_PROCESOS.f_get_max_n_convoca( ln_n_convoca ) INTO ln_n_convoca_max FROM dual;

     ---------- Obtiene el codigo de objeto de la convocatoria --------
     SELECT codobjeto INTO ln_codobjeto FROM REG_PROCESOS.convocatorias WHERE n_convoca = ln_n_convoca;


             ------------------------- Obtiene el tipo de archivo ARAMIREZ -------------------------------------

   BEGIN
        --select cod_tipo_file into lv_codtipofile From Reg_procesos.tipo_archivo Where ext_tipo_file=upper(substr(pfiletoupload_file1,length(pfiletoupload_file1)-2,length(pfiletoupload_file1)));
        select cod_tipo_file into lv_codtipofile From Reg_procesos.tipo_archivo Where ext_tipo_file=upper(substr(pfiletoupload_file1,(INSTR(pfiletoupload_file1,'.',1) + 1)));
   EXCEPTION
   WHEN OTHERS THEN
          usp_print(
                pku_procesos_comun.f_putMensaje(
                    'Error: Al intentar registrar el archivo.',
                    '')
            );
           return;
   END;

   ------------------------- Fin de Obtiene el tipo de archivo  ARAMIREZ------------------------------

     ---------- Grabar Nuevo Contrato -----------

     insert into REG_PROCESOS.contrato
     (  n_cod_contrato, n_contrato, n_cod_contrato_de_renovac,
        n_convoca, f_contrato, m_contratado, codmoneda_contrato,
        des_causa_renovacion, des_contrato, plazo, f_culminacion,
        codconsucode, anhoentidad,cod_operacion_contrato,
        codconsucode_paga, anhoentidad_paga
     ) values
     (
       ln_cod_contrato, ag_n_contrato, ln_cod_contrato_ren,
       ln_n_convoca, ld_f_contrato, ln_m_contratado, ln_cod_moneda,
       lv_des_causa_renov, lv_des_contrato, ln_plazo, ld_f_culminacion,
       lv_codconsucode, lv_anhoentidad,ln_cod_operacion_cont,
       ag_codconsucode_paga, ag_anhoentidad_paga
     );

     ---------- Insertar Items Prorrogados --------
     usp_registra_items(ag_trama_items,ln_cod_contrato,ln_n_convoca);

    ---------- Grabar Calendario de Pagos ----------
    if ln_ind_siaf = 1 then
     usp_registra_calendario(ag_trama_calendario);
    end if;
    ----------- Actualiza la Ultima Operacion del Contrato ----

    update REG_PROCESOS.contrato  set
           ID_OPERACION = REG_PROCESOS.PK_CONVOCATORIA.getidoperacion()
    where n_cod_contrato = ln_cod_contrato;

    ----------- Actualiza el Costo Final ---------
    reg_procesos.pku_ss_make_contrato.usp_calcula_costoFinal(ln_cod_contrato_ren);

    ----------- Transfiere al MEF ------------
    ----------- Si es complementario se transfiere al MEF -----------
--    if (ln_cod_operacion_cont = 6) then
--        REG_PROCESOS.PK_TRANS_MEF.SP_WS_MEF_SEND_OPERACION(REG_PROCESOS.PK_CONVOCATORIA.getidoperacion());
--    elsif (ln_codobjeto != 1) then
    ----------- Si es Prorroga y el objeto no es Bienes se transfiere al MEF -----------
        REG_PROCESOS.PK_TRANS_MEF.SP_WS_MEF_SEND_OPERACION(REG_PROCESOS.PK_CONVOCATORIA.getidoperacion());
--    end if;


             ---- aramirez inicio

   lv_anhoentidad := ag_anhoentidad;
   lv_eue_codigo := session__eue_codigo;    
   lv_directorio := gpk_directorio_adicred;
   lv_ruta := lv_directorio||'\'||lv_anhoentidad||'\'||lpad(lv_eue_codigo,6,'0')||'\'||ag_n_convoca; 

   usp_print('
     <input type ="hidden" name=WriteFileDirectoryDynamic value="'||lv_ruta||'" type=text>
     <input type ="hidden" name=WriteFileDirectory value="FileSinged" type=text>
   ');



     BEGIN

            select max(N_COD_CONTRATO) into lv_id_redu from REG_PROCESOS.contrato where n_cod_contrato=ln_cod_contrato;

            if ln_cod_operacion_cont=2 then

        REG_PROCESOS.PKU_GESTOR_CONT_UTILES_2.p_insUploadprorroga(
              reg_procesos.f_get_min_n_convoca(session__N_CONVOCA),
              TO_DATE (ag_fec_doc_adicional,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
              'NULL',--doc_obs,
              lv_codtipofile,
              pfiletoupload_file1,
              SizeFile,
              session__userid,
              iisenv__remote_host,
              WriteFileDirectoryDynamic,
              ln_cod_contrato,
              lv_id_redu);

           ELSIF ln_cod_operacion_cont=6 then   

              REG_PROCESOS.PKU_GESTOR_CONT_UTILES_2.p_insUploadComplementario(
              reg_procesos.f_get_min_n_convoca(session__N_CONVOCA),
              TO_DATE (ag_fec_doc_adicional,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
              'NULL',--doc_obs,
              lv_codtipofile,
              pfiletoupload_file1,
              SizeFile,
              session__userid,
              iisenv__remote_host,
              WriteFileDirectoryDynamic,
              ln_cod_contrato,
              lv_id_redu);

              end if;

   EXCEPTION
      WHEN OTHERS THEN
          usp_print(
                pku_procesos_comun.f_putMensaje(
                    'Error: Al intentar registrar el Documento.',
                    '')
            );
           return;

   END;

----- aramirez fin    




    commit;


    usp_print('
    <script language=javascript>
       thisform.scriptdo.value="LisProrrogasDoView";
       thisform.submit();
    </script>
    ');
   ---termina aqui
       end if;

   End;


--------------------------------------------------------------------------------------------------
---------- uspNewProItemDoEdit ---------
--------------------------------------------------------------------------------------------------
      PROCEDURE uspNewProItemDoEdit
     ( ag_id_usuario            varchar2,
       ag_n_convoca             varchar2,
       ag_cod_contrato          varchar2,
       ag_n_contrato            varchar2,
       ag_cod_moneda            varchar2,
       ag_f_contrato            varchar2,
       ag_m_contratado          varchar2,
       ag_des_causa_renov       varchar2,
       ag_des_contrato          varchar2,
       ag_plazo                 varchar2,
       ag_f_culminacion         varchar2,
       ag_codconsucode          varchar2,
       ag_anhoentidad           varchar2,
       ag_cod_operacion         varchar2,
       ag_ncor_orden_pedido     varchar2,
       ag_cant_items            varchar2,
       ag_currenpage            varchar2,
       session__N_CONVOCA       varchar2 default null,
       session__COD_CONTRATO    varchar2 default null,
       ag_trama_calendario      varchar2 default null,
       ag_pagina_retorno        varchar2 default null,
       ag_proc_tipo             varchar2) Is

   ----------- Variables ---------
   lv_procedure_main    varchar2(100);
   ln_cod_contrato      number;
   ln_cod_operacion     number;
   ln_Fila_Ini       number;
   ln_Fila_Fin       number;
   ln_Item_Ini       number;
   ln_Item_Fin       number;

   lv_trama_items    VARCHAR2(32000);
   Begin

    lv_procedure_main  := 'uspNewProItemDoEdit';
    ln_cod_contrato    := to_number(ag_cod_contrato);
    ln_cod_operacion   := to_number(ag_cod_operacion);

--usp_print('session__COD_CONTRATO:'||session__COD_CONTRATO);
--usp_print('<br>ln_cod_operacion:'||ln_cod_operacion);

   lv_trama_items := PKU_GESTOR_CONT_UTILES_3.f_getXmlItemsComPro_sel(session__COD_CONTRATO,ln_cod_operacion);
   usp_print('<script>');
   usp_print(lv_trama_items);
   usp_print('</script>');


    -------------------------- Funciones Script ----------------------------

   --PKU_GESTOR_CONT_FUNCIONES_JS_3.fValidaCadenas_JS;
     PKU_GESTOR_CONT_FUNCIONES_JS_3.fNumeros;
     PKU_GESTOR_CONT_FUNCIONES_JS_3.fXmlPaginacion;
       ----------------- Muestra los Items -----------------

   usp_print('<xml id="xmlActual"><root></root></xml>');
    ---------------- Captura Valores de la Pantalla Principal --------------

   usp_print('
        <input type="hidden"  name ="ag_id_usuario"           value="'||ag_id_usuario||'" />
        <input type="hidden"  name ="ag_n_convoca"            value="'||ag_n_convoca||'" />
        <input type="hidden"  name ="ag_cod_contrato"         value="'||ln_cod_contrato||'" />
        <input type="hidden"  name ="ag_n_contrato"           value="'||ag_n_contrato||'" />
        <input type="hidden"  name ="ag_cod_moneda"           value="'||ag_cod_moneda||'" />
        <input type="hidden"  name ="ag_f_contrato"           value="'||ag_f_contrato||'" />
        <input type="hidden"  name ="ag_m_contratado"         value="'||ag_m_contratado||'" />
        <input type="hidden"  name ="ag_des_causa_renov"      value="'||ag_des_causa_renov||'" />
        <input type="hidden"  name ="ag_des_contrato"         value="'||ag_des_contrato||'" />
        <input type="hidden"  name ="ag_plazo"                value="'||ag_plazo||'" />
        <input type="hidden"  name ="ag_f_culminacion"        value="'||ag_f_culminacion||'" />
        <input type="hidden"  name ="ag_codconsucode"         value="'||ag_codconsucode||'" />
        <input type="hidden"  name ="ag_anhoentidad"          value="'||ag_anhoentidad||'" />
        <input type="hidden"  name ="ag_cod_operacion"        value="'||ln_cod_operacion||'" />
        <input type="hidden"  name ="ag_ncor_orden_pedido"    value="'||ag_ncor_orden_pedido||'" />
        <input type="hidden"  name ="ag_next_url"             value=""/>
        <input type="hidden"  name="ag_caditem_nreg"          value=""/>
        <input type="hidden"  name="ag_caditem_item"          value=""/>
        <input type="hidden"  name="ag_caditem_unid"          value=""/>
        <input type="hidden"  name="ag_caditem_cant"          value=""/>
        <input type="hidden"  name="ag_caditem_monto"         value=""/>
        <input type="hidden"  name="ag_fila_inicio" />
        <input type="hidden"  name="ag_fila_fin" />
        <input type="hidden"  name="ag_proc_tipo"             value="'||ag_proc_tipo||'"/>
        ');
    usp_print('<input type="hidden"  name="ag_trama_items"    value="" />');
    usp_print('<input type="hidden"  name="ag_trama_calendario"     value="'||ag_trama_calendario||'" />');


    usp_print('
    <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
        <tr>');
    usp_print(
            PKU_GESTOR_CONT_UTILES_3.f_get_titulo_contrato ( session__COD_CONTRATO, 'Prorrogas/Complementarios' )
    );
    usp_print('
            <td align="right" valign=top width="50%">
                <input type="button" value="Volver" OnClick="thisform.scriptdo.value='''||ag_pagina_retorno||''';thisform.submit();"/>
                <input type="button" value="Continuar" OnClick="generaTrama('''||ag_pagina_retorno||''')"/>
            </td>
         </tr>
    </table>
    <br>');


    usp_print('
    <script>
    function redondear( num, dec )
        {
            num = parseFloat(num);
            dec = parseFloat(dec);
            dec = (!dec ? 2 : dec);
            return Math.round(num * Math.pow(10, dec)) / Math.pow(10, dec);
        }

   $(document).ready(function(){
           var myObject = eval(''('' + itemJSON + '')'');                 
                  for (i in myObject)
                  {   $(''#tablaItems tr:last'').
                          after("<tr class=TabFilMan>"+

                                   "<td>"+myObject[i][''chkcc'']+"</td>"+

                                   "<td>"+myObject[i][''fila'']+"</td>"+

                                   "<td>"+myObject[i][''procitem'']+"</td>"+

                                   "<td>"+myObject[i][''descripcion'']+"</td>"+

                                   "<td>"+myObject[i][''unidad'']+"</td>"+

                                   "<td>"+myObject[i][''cantidad'']+"</td>"+

                                   "<td>"+myObject[i][''mon'']+"</td>"+');

                                   if ln_cod_operacion = 6 and ag_proc_tipo not in (11,23) then
                                                 usp_print('"<td>"+myObject[i][''top'']+"</td>"+');
                                   else
                                                 usp_print('"<td style=''display:none''>"+myObject[i][''top'']+"</td>"+'); 
                                   end if;

                                usp_print('"<td><input type=''text'' datafld=''monto'' name=''txtMontoxml'' size=''15'' style=''text-align:left'' onkeyup=''validarInputNumDecimal(this)'' onblur=''validarFormInputNumDecimal(this); this.value = redondear(this.value, 2)''></input></td>"+
                                           "<td style=''display:none''>"+myObject[i][''top'']+"</td>"+
                                           "<td style=''display:none''>"+myObject[i][''sum'']+"</td>"+                                           
                                           ');
                                     usp_print('"</tr>");                    
                   }
        }); 
   ');
usp_print('</script>'); 


    ----------- Tabla de resultados --------------------
    usp_print('
        <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
            <tr align="center" valign = "top">
               <td colspan = 6 align="right"><div id="paginacion"></div></td>
             </tr>
       </table>');

    ---------- Cabecera de los Items ---------------

     usp_print('
      <table align="center" BORDER="0" CELLPADDING="3" CELLSPACING="0" width="100%">
            <tr>
                <td>');

    ---------- Cabecera de los Items ---------------
   usp_print('
   <input type="hidden" name=chkObjs >
<input type="hidden" name=chkObjs >
     <table id="tablaItems" datapagesize="10" class="table table-bordered">
     <thead>
          <tr align="center">
          <td><b>Adicionar Items</b></td>
          <td><b>N</b></td>
          <td><b>Item</b></td>
          <td><b>Descripcion</b></td>
          <td><b>Unidad de Medida</b></td>
          <td><b>Cantidad</b></td>
          <td><b>Monto Item Original</b></td>');

   if ln_cod_operacion = 6 and ag_proc_tipo not in ( 11,23) then
   usp_print('<td><b>Monto Adicional Maximo</b></td>');
   end if;

   usp_print('<td><b>Monto Adicional Item </b></td>
          </tr>
      </thead>
       </table>');

   usp_print('</td>
    </tr>
    <tr>
     <td colspan = 3 align="left"><div id="filas"></div></td>
    </tr>
 </table>');

     ------------- Botones Finales ---------------
     usp_print('
        <br/>
        <input type="hidden" name="ag_Item_Ini" value="'||ln_Item_Ini||'"/>
        <input type="hidden" name="ag_Item_Fin" value="'||ln_Item_Fin||'"/>
        ');

     ----------------- Java Script --------------
     usp_print('
       <script language="javascript">



        function cambio_pagina(obj,FilaIni,FilaFin,nextpage){
            if(VerificarContenido("0")){
                thisform.ag_currenpage.value=nextpage;
                thisform.ag_fila_inicio.value=FilaIni;
                thisform.ag_fila_fin.value=FilaFin;
                thisform.ag_next_url.value="'||lv_procedure_main||'";
                thisform.scriptdo.value="NewProItemDoInsert";
                thisform.submit();
                return true;
            }
        }

        function volver(pagina,FilaIni,FilaFin,destino)
        {
            if(VerificarContenido("0"))
            {
                thisform.ag_fila_inicio.value=FilaIni;
                thisform.ag_fila_fin.value=FilaFin;
                if(destino==1)
                  { thisform.ag_next_url.value="NewProrrogaDoEdit"; }
                else
                  { thisform.ag_next_url.value="ManProrrogaDoEdit"; }
                thisform.scriptdo.value="NewProItemDoInsert";
                thisform.submit();
                return true;

            }
        }

       </script>
     ');

  PKU_GESTOR_CONT_FUNCIONES_JS_3.fXmlProrrogaComplementario;

      ----------------- Java Script --------------
 --   PKU_SS_FUNCIONES_JS3.js_script(' paginacion(xmlItems,10,1);');

  End;


  /**********************************************************************/
  PROCEDURE uspManProrrogaDoEdit
     (
       ag_cod_contrato          varchar2 DEFAULT Null,
       ag_cod_operacion         varchar2,
       ag_des_causa_renov       varchar2,
       ag_f_contrato            varchar2,
       ag_f_culminacion         varchar2,
       ag_n_contrato            varchar2,
       ag_cm_opc                varchar2,
       ag_cm_oper_compra        varchar2,
       session__userid          varchar2 default null,
       session__N_CONVOCA    varchar2 default null,
       session__COD_CONTRATO varchar2 default null,
       ag_trama_items           VARCHAR2,
       ag_trama_calendario      VARCHAR2,
       ag_fec_doc_cgr                  VARCHAR2,                     -- del cgr
       ag_nro_doc_cgr                  VARCHAR2                     -- del cgr

       ) Is

   ------- Variables ------
   e_ArgumentosMalos            exception;
   lv_eue_codigo                varchar2(20);
   lv_anhoentidad               varchar2(20);
   lv_procedure_main            varchar2(100);
   ln_n_convoca                 number;
   lv_proc_sigla                varchar2(200);
   lv_proc_tipo_sigla           varchar2(200);
   lv_proc_num                  varchar2(200);
   ln_proc_tipo                 number;
   ln_n_proceso                 number;
   ln_cod_contrato              number;
   ln_cod_contrato_ren          number;
   ln_ind_siaf                  number;
   lv_n_contrato                REG_PROCESOS.contrato.n_contrato%type;
   lv_ruc_contratista           REG_PROCESOS.contrato.ruc_contratista%type;
   lv_nom_contratista           REG_PROCESOS.contrato.nom_contratista%type;
   lv_n_contrato_ren            REG_PROCESOS.contrato.n_contrato%type;
   lv_f_contrato                varchar2(10);
   lv_des_contrato              REG_PROCESOS.contrato.des_contrato%type;
   lv_codmoneda_contrato        REG_PROCESOS.contrato.codmoneda_contrato%type;
   lv_des_moneda                REG_PROCESOS.monedas.descripcion%type;
   lv_simbolo                   REG_PROCESOS.monedas.simbolo%type;
    --nuevo requerimiento para adicional
   ad_cod_entid_autoriza        reg_procesos.contrato.codconsucode_paga%TYPE;
   lv_id_usuario                varchar2(30);
   lv_f_contrato_pro            varchar2(10);
   lv_f_contrato_com            varchar2(10);
   ln_total_calendario          number;
   ln_ncor_orden_pedido         number;
   ln_monto_items               number;
   ln_cant_items_sel            number;
   ln_max_item                  number;
   ln_CantItems_Cont            number;
   ln_m_contratado              number;
   ln_plazo                     number;
   lv_des_causa_renovacion      varchar2(1000);
   lv_f_culminacion             varchar2(10);
   ln_cod_operacion             number;
   lv_des_operacion             varchar2(250);
   lv_codconsucode_paga         varchar2(6);
   lv_anhoentidad_paga          varchar2(4);
   lv_f_vigencia_fin            varchar2(10);
   ln_monto_contr_orig          number;
   lv_ind_consorcio             varchar2(5);
   ag_id_usuario                varchar2(20);
   lv_textoFormulario           varchar2(800);

   coperacion                   ref_cursor;

   lv_combo_operacion           varchar2(4000);
   ln_codobjeto                 NUMBER;
   ln_cont_dias                 NUMBER;

   ln_pro_comp                  NUMBER;
   -- Items
   lv_trama_items               varchar2(32000);
   lv_trama_calendario          varchar2(32000);


   -- variables de los datos del upload--aramirez
      ln_NCOD_DOC                    NUMBER;-----aramirez
      lv_DOC_URL                     VARCHAR2(250);----aramirez
      lv_FEC_UPLOAD                  VARCHAR2(20);----aramirez
      lv_USER_UPLOAD                 VARCHAR2(30);----aramirez
      lv_FEC_APROB                   VARCHAR2(20);----aramirez
      lv_EXT_TIPO_FILE               VARCHAR2(250);----aramirez
      lv_ICON_TIPO_FILE              VARCHAR2(250);----aramirez
      lv_DOC_OBS                     VARCHAR2(250);----aramirez
      lv_id_adi                         NUMBER;----aramirez


  BEGIN

   ln_codobjeto        := PKU_GESTOR_CONT_UTILES_3.f_getcodobjeto(session__N_CONVOCA);

   coperacion          := PKU_GESTOR_CONT_UTILES_3.f_coperacionesAdenda(ln_codobjeto,session__N_CONVOCA);
   ln_cont_dias        := PKU_GESTOR_CONT_UTILES_3.f_getnumdiasoperaciones(session__COD_CONTRATO,ag_cod_operacion ) ;

   lv_trama_items      := nvl(ag_trama_items,PKU_GESTOR_CONT_UTILES_3.f_getXmlItemsComPro(ag_cod_contrato,ag_cod_operacion));
   lv_trama_calendario := nvl(ag_trama_calendario,PKU_GESTOR_CONT_UTILES_3.f_getXmlCalAdionReduc(f_get_id_operacion(ag_cod_contrato)));

/*   usp_print(lv_trama_items);
*/
   ag_id_usuario := session__userid;

     lv_procedure_main      := 'ManProrrogaDoEdit';
     ln_cod_contrato        := to_number(ag_cod_contrato);
     ln_n_convoca           := to_number(session__N_CONVOCA);
     lv_id_usuario          := trim(ag_id_usuario);
     ln_cod_contrato_ren    := session__COD_CONTRATO;--  ag_cod_contrato_ren;


     -------- Funciones Script -------
/*     REG_PROCESOS.PKU_SS_FUNCIONES_JS3.fValidaCadenas_JS;
*/  PKU_GESTOR_CONT_FUNCIONES_JS_3.fFechasGeneral;
    PKU_GESTOR_CONT_FUNCIONES_JS_3.fValidacionesGeneral;
    PKU_GESTOR_CONT_FUNCIONES_JS_3.sp_javascript_contratos;------------------------------------

      ----- Obtener Datos de la Convocatoria-------
    if (ln_n_convoca is not null) then
        begin
           Select c.codconsucode,c.n_proceso,
                  c.anhoentidad,c.proc_tipo,c.proc_num,
                  c.proc_sigla,t.proc_tipo_sigla
           into   lv_eue_codigo,ln_n_proceso,
                  lv_anhoentidad,ln_proc_tipo,lv_proc_num,
                  lv_proc_sigla,lv_proc_tipo_sigla
           from REG_PROCESOS.convocatorias c,
                REG_PROCESOS.tipo_procesos t
           where t.proc_tipo =c.proc_tipo
             and c.n_convoca = ln_n_convoca;
          exception
             when no_data_found then
                  lv_eue_codigo:= null;
        end;
    else  --------- Convenio Marco -----------
        begin
           Select o.codconsucode,'' n_convoca,
                  o.anhoentidad,'' proc_tipo,'' proc_num,
                  '' proc_sigla,'' proc_tipo_sigla
           into   lv_eue_codigo,ln_n_convoca,
                  lv_anhoentidad,ln_proc_tipo,lv_proc_num,
                  lv_proc_sigla,lv_proc_tipo_sigla
           from reg_procesos.cm_orden_pedido o, REG_PROCESOS.contrato c
           where o.ncor_orden_pedido = c.ncor_orden_pedido
             and c.n_cod_contrato = ln_cod_contrato;
           exception
             when no_data_found then
                  lv_eue_codigo:= null;
        end;
    end if;


   --- Texto
   if (ag_cod_operacion = 2) then
     lv_textoFormulario := ' de la Prorroga';
   elsif (ag_cod_operacion = 6) then
     lv_textoFormulario := ' del Contrato Complementario ';
   end if;


    ----- Obtener Datos del Contrato ----
    begin

    Select c.des_contrato,
           to_char(c.f_contrato, REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_fecha) f_contrato,
           c.n_contrato,
           c.codmoneda_contrato,
           c.m_contratado,c.plazo,
           c.des_causa_renovacion,
           to_char(c.f_culminacion,REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_fecha) f_culminacion,
           m.descripcion, m.simbolo,
           c.ncor_orden_pedido, c.cod_operacion_contrato,
           t.des_operacion_contrato,
           c.codconsucode_paga, c.anhoentidad_paga
      into lv_des_contrato,
           lv_f_contrato,
           lv_n_contrato,
           lv_codmoneda_contrato,
           ln_m_contratado,ln_plazo,
           lv_des_causa_renovacion,
           lv_f_culminacion,lv_des_moneda, lv_simbolo,
           ln_ncor_orden_pedido, ln_cod_operacion,
           lv_des_operacion, lv_codconsucode_paga,
           lv_anhoentidad_paga
      from reg_procesos.contrato c,
           reg_procesos.monedas m,
           reg_procesos.tipo_operacion_contrato t
      where c.codmoneda_contrato = m.codmoneda(+)
        and c.cod_operacion_contrato = t.cod_operacion_contrato(+)
        and c.n_cod_contrato = ln_cod_contrato;
      exception
         when no_data_found then
              lv_n_contrato:= null;
    end;
   ------------------------------------------------------------------------------------------------------------------------------
   --- Combos ---
   lv_combo_operacion  := PKU_GESTOR_CONT_UTILES_3.f_retorna_combo(coperacion, 'ag_cod_operacio', ln_cod_operacion,'Seleccione...','style="width:340px"  disabled');
   ------------------------------------------------------------------------------------------------------------------------------

 --  if (ln_cod_contrato_ren is not null) then
        begin
            Select c.n_contrato, c.ruc_contratista,
                   c.nom_contratista, c.m_contratado,
                   to_char(c.f_vigencia_fin, REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_fecha),
                   c.ind_consorcio
            into lv_n_contrato_ren, lv_ruc_contratista,
                 lv_nom_contratista, ln_monto_contr_orig,
                 lv_f_vigencia_fin, lv_ind_consorcio
            from REG_PROCESOS.contrato c
            where c.n_cod_contrato = ln_cod_contrato_ren;
            exception
               when no_data_found then
                    lv_ruc_contratista:= null;
        end;
  --  end if;

    if (ag_n_contrato is not null) then
        lv_n_contrato:= ag_n_contrato;
    end if;
    if (ag_f_contrato is not null) then
        lv_f_contrato:= ag_f_contrato;
    end if;
    if (ag_f_culminacion is not null) then
        lv_f_culminacion:= ag_f_culminacion;
    end if;
    if (ag_des_causa_renov is not null) then
        lv_des_causa_renovacion:= ag_des_causa_renov;
    end if;


    -------- Ultimo item del contrato -------
    select max(c.proc_item), count(c.proc_item)
    into   ln_max_item, ln_CantItems_Cont
    from reg_procesos.item_contrato c
    where c.n_cod_contrato = ln_cod_contrato_ren;

   -------- Fecha Maxima de Prorrogas -------
    select to_char(max(f_contrato), REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_fecha)
    into lv_f_contrato_pro
    from REG_PROCESOS.convocatorias co,
         REG_PROCESOS.contrato c
    where co.n_convoca                   = c.n_convoca
      and c.n_convoca                    = ln_n_convoca
      and c.n_cod_contrato_de_renovac    = ln_cod_contrato
      and c.cod_operacion_contrato       = 2;

    -------- Fecha Maxima de Complementarios -------
    select to_char(max(f_contrato), REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_fecha)
    into lv_f_contrato_com
    from REG_PROCESOS.convocatorias co,
         REG_PROCESOS.contrato c
    where co.n_convoca                   = c.n_convoca
      and c.n_convoca                    = ln_n_convoca
      and c.n_cod_contrato_de_renovac    = ln_cod_contrato
      and c.cod_operacion_contrato       = 6;

    ----------- Obtener el Indicador de Transferencia al SIAF ---------
    begin
        select ep.ind_uso_siaf
        into ln_ind_siaf
        from reg_procesos.entidadue_anho_tipo_proceso ep,
             reg_procesos.convocatorias c,
             reg_procesos.contrato cnt
        where ep.eue_codigo = c.codconsucode
          and ep.eue_anho   = c.anhoentidad
          and c.n_convoca   = cnt.n_convoca
          and cnt.n_cod_contrato = ln_cod_contrato
          and c.proc_tipo   = ep.tip_codigo;
         exception
            when no_data_found then
                 ln_ind_siaf:= null;
   end;

   ------- Monto Total Calendario ---------
   Select nvl(sum(nvl(a.monto_pago,0)),0)
   into ln_total_calendario
   from reg_procesos.tmp_contrato_prorroga_cal a
   where a.id_usuario = lv_id_usuario
     and a.n_cod_contrato = ln_cod_contrato;

   ------- Monto y Numero de Items Seleccionados ---------
   Select  nvl(sum(nvl(a.monto,0)),0), count(a.proc_item)
   into ln_monto_items, ln_cant_items_sel
   from reg_procesos.tmp_contrato_prorroga_item a
   where a.id_usuario = lv_id_usuario
     and a.n_cod_contrato = ln_cod_contrato_ren;

   -------- Titulos ------------
   usp_print('
    <div>
        <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
            <tr>');
        usp_print(
                PKU_GESTOR_CONT_UTILES_3.f_get_titulo_contrato (session__cod_contrato, 'Modificar Prorrogas/Contratos Complementarios' )
        );
       SELECT COUNT(*)INTO ln_pro_comp  
       FROM REG_PROCESOS.CONTRATO
       WHERE COD_OPERACION_CONTRATO IN (2,6) 
       AND N_COD_CONTRATO=ln_cod_contrato;  

       if (ln_pro_comp>0) then
        usp_print('
                <td align="right" valign=top width="50%">
                    <input type="button" value="Volver" OnClick="cancelar()">
                </td>           
        ');   
        else 
        usp_print('
                <td align="right" valign=top width="50%">
                    <input type="button" value="Volver" OnClick="cancelar()">
                    <input type="button" value="Grabar" OnClick="grabar()">
                    <input type="button" value="Seleccionar Items" OnClick="seleccionaritems()">
                </td>

        ');
        end if;
        usp_print('
             </tr>
        </table>
     </div>
     <br/>
       <input type="hidden" name="f_vigencia_actualizada"  id="f_vigencia_actualizada"   value="'||substr(PKU_GESTOR_CONT_UTILES_3.f_get_fecha_fin_amp(session__COD_CONTRATO),1,10)||'"/>
      <!--  <input type="hidden" name="ag_des_contrato"              value="'||lv_des_contrato||'"/>    -->
       <input type="hidden" name="ag_cod_contrato_ren"          value="'||ln_cod_contrato_ren||'"/>
       <input type="hidden" name="ag_id_usuario"                value="'||lv_id_usuario||'"/>
     <!--  <input type="hidden" name="ag_n_contrato"                value="'||lv_n_contrato||'"/>       -->
       <input type="hidden" name="ag_n_convoca"                 value="'||ln_n_convoca||'"/>
       <input type="hidden" name="ag_cod_contrato"              value="'||ln_cod_contrato||'"/>
       <input type="hidden" name="f_contrato_pen"               value="'||lv_f_contrato_pro||'"/>
       <input type="hidden" name="f_contrato_pencomp"           value="'||lv_f_contrato_com||'"/>
       <input type="hidden" name="f_contrato_ori"               value="'||lv_f_contrato||'"/>
       <input type="hidden" name="ag_cod_contrato_ren"          value="'||ln_cod_contrato_ren||'"/>
       <input type="hidden" name="m_total_calendario"           value="'||ln_total_calendario||'"/>
       <input type="hidden" name="ag_ind_siaf"                  value="'||ln_ind_siaf||'"/>
       <input type="hidden" name="ag_num_pago" />
       <input type="hidden" name="ag_fecha_pago" />
       <input type="hidden" name="ag_monto_pago" />
       <input type="hidden" name="ag_reg_cal_modif" value=""/>
       <input type="hidden" name="ag_caditem_item" value=""/>
       <input type="hidden" name="ag_caditem_unid" value=""/>
       <input type="hidden" name="ag_caditem_cant" value=""/>
       <input type="hidden" name="ag_caditem_monto" value=""/>
       <input type="hidden" name="ag_codconsucode"              value="'||lv_eue_codigo||'" />
       <input type="hidden" name="ag_anhoentidad"               value="'||lv_anhoentidad||'" />
       <input type="hidden" name="ag_ncor_orden_pedido"         value="'||ln_ncor_orden_pedido||'" />
       <input type="hidden" name="ag_cm_opc"                    value="'||ag_cm_opc||'" />
       <input type="hidden" name="ag_cm_oper_compra"            value="'||ag_cm_oper_compra||'" />
       <input type="hidden" name="ag_cant_items"                value="'||ln_CantItems_Cont||'" />
       <input type="hidden" name="ag_ini_editar" value="0"/>
       <input type="hidden" name="ag_next_url"                  value="'||lv_procedure_main||'" />
       <input type="hidden" name="ag_tipo_op" value="2" />
       <input type="hidden" name="ag_codconsucode_paga"         value="'||lv_codconsucode_paga||'" />
       <input type="hidden" name="ag_anhoentidad_paga"          value="'||lv_anhoentidad_paga||'" />
       <input type="hidden" name="ag_fecfin_origen"             value="'||lv_f_vigencia_fin||'"/>
       <input type="hidden" name="ag_f_vigencia_fin"             value="'||lv_f_vigencia_fin||'"/>
       <input type="hidden" name="monto_contr_orig"             value="'||ln_monto_contr_orig||'"/>
       <input type="hidden" name="monto_prorroga"               value="'||ln_monto_items||'" />
       <input type="hidden" name="ag_ruc_contratista"           value="'||lv_ruc_contratista||'" />
       <input type="hidden" name="ag_ind_consorcio"             value="'||lv_ind_consorcio||'" />
       <input type="hidden" name="ag_back_page"                 value="'||lv_procedure_main||'" />
       <input type="hidden" name="ag_proc_item"                 value="">
       <input type="hidden" name="ag_cod_operacion"             value="'||ag_cod_operacion||'">
       <input type="hidden"  name="ag_pagina_retorno"          value="ManProrrogaDoEdit"/>
       <input type="hidden" name="ag_cont_dias"             value="'||ln_cont_dias||'" />
       <input type="hidden" name="ag_trama_items"           value="" />
      ');

    -- para calcular si las cantidades son iguales
    usp_print('
              <input type ="hidden" name="an_total_items"           value=""/>
              <input type ="hidden" name="an_total_calendario"      value=""/>');

    usp_print('<input type="hidden"  name="ag_trama_calendario" value="" />');          
       ------- Numero del Contrato --------
    usp_print('
        <table width=100% class="table table-striped">
        ');

    usp_print('
            <tr>
              <td style="width:33%">Tipo operacion del Contrato Original</td>
              <td style="width:33%">'||lv_combo_operacion||'</td>
              <td style="width:34%">Tipo de Documento</td>
            </tr>');

    usp_print('
        <tr>
            <td class=c1>Objeto '||lv_textoFormulario||'</td>
            <td class=c2>
                <input type=text name="ag_des_contrato" value="'||lv_des_contrato||'" disabled=true size=54>
            </td>
            <td class=c3>Objeto que describe el contrato</td>
        </tr>
        <tr>
            <td class=c1>Numero '||lv_textoFormulario||'</b></td>
            <td class=c2>
                 <input name="ag_n_contrato" class="form-control" value="'||lv_n_contrato||'" size=54 disabled=true>
            </td>
            <td class=c3>Numero del Contrato Prorrogado</td>
        </tr>
        <tr>
            <td class=c1>Fecha '||lv_textoFormulario||'</td>
            <td class=c2>
              <input  class=CalSelect type=text size=50 name="ag_f_contrato" readonly onclick="thisform.ag_plazo.value= diasEntre(thisform.f_vigencia_actualizada.value,thisform.ag_f_culminacion.value)" value="'||lv_f_contrato||'">
            </td>
            <td class=c3>Fecha del Contrato</td>
        </tr>
        <tr>
            <td class=c1>Fecha de Culminacion '||lv_textoFormulario||'</td>
            <td class=c2>
              <input  class=CalSelect type=text size=50 name="ag_f_culminacion" readonly onclick="thisform.ag_plazo.value= diasEntre(thisform.f_vigencia_actualizada.value,thisform.ag_f_culminacion.value)" value="'||lv_f_culminacion||'">
            </td>
            <td class=c3>Fecha de Culminacion</td>
        </tr>
        <tr>
            <td class=c1>Moneda</td>
            <td class=c2>
               <input name="ag_cod_moneda" type="hidden" value="'||lv_codmoneda_contrato||'" />
               <b>'||lv_des_moneda||'</b>
            </td>
            <td class=c3>Moneda '||lv_textoFormulario||'</td>
        </tr>
        <tr>
            <td class=c1>Monto '||lv_textoFormulario||'</td>
            <td class=c2><input class="form-control" name="ag_m_contratado" value="'||to_char(ln_m_contratado,REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_dinero)||'" readOnly="true" maxlength="11" size=54 /></td>
            <td class=c3>Monto '||lv_textoFormulario||'</td>
        </tr>');

        usp_print('
        <tr>
            <td class=c1>Plazo '||lv_textoFormulario||'</td>
            <td class=c2><input class="form-control" name="ag_plazo" value="'||ln_plazo||'" readOnly="true" maxlength="11" size=54 /></td>
            <td class=c3>Plazo '||lv_textoFormulario||'</td>
        </tr>
        <tr>
            <td class=c1>Causa '||lv_textoFormulario||'</td>
            <td class=c2>
                <input type=text name="ag_des_causa_renov" value="'||lv_des_causa_renovacion||'" size=54>
            </td>
            <td class=c3>Observaciones</td>
        </tr>');
        --aramirez inicio

        if ag_cod_operacion=2 then
        REG_PROCESOS.pku_gestor_cont_utiles_2.p_last_upload_prorroga( ag_cod_contrato, session__N_CONVOCA, ln_NCOD_DOC,lv_DOC_URL,lv_FEC_UPLOAD ,lv_USER_UPLOAD,lv_FEC_APROB ,lv_EXT_TIPO_FILE,lv_ICON_TIPO_FILE, lv_DOC_OBS,ag_cod_contrato);
        usp_print( '<tr> <td class=c1>Archivo de la Prorroga </td> <td >' || case when lv_DOC_URL is not null then '<a target=_blank href="'||url_azure_app||lv_DOC_URL||'">
                <img src="'||lv_ICON_TIPO_FILE||'" border="0" width="25" height="25"/></a>' 
                end || case when lv_FEC_UPLOAD is not null then ' Registrado el '||lv_FEC_UPLOAD end||'<input type="hidden" name="pfiletoupload_file1" value=""/>

          </td>
          </tr>');
          end if;

           if ag_cod_operacion=6 then
        REG_PROCESOS.pku_gestor_cont_utiles_2.P_last_upload_complementario( ag_cod_contrato, session__N_CONVOCA, ln_NCOD_DOC,lv_DOC_URL,lv_FEC_UPLOAD ,lv_USER_UPLOAD,lv_FEC_APROB ,lv_EXT_TIPO_FILE,lv_ICON_TIPO_FILE, lv_DOC_OBS,ag_cod_contrato);
        usp_print( '<tr> <td class=c1>Archivo del Contrato Complementario </td> <td >' || case when lv_DOC_URL is not null then '<a target=_blank href="'||url_azure_app||lv_DOC_URL||'">
                <img src="'||lv_ICON_TIPO_FILE||'" border="0" width="25" height="25"/></a>' 
                end || case when lv_FEC_UPLOAD is not null then ' Registrado el '||lv_FEC_UPLOAD end||'<input type="hidden" name="pfiletoupload_file1" value=""/>

          </td>
          </tr>');
          end if;


          usp_print('</table>
      <br>');

   -- aramirez fin








  /*  ----aramirez inicio

 -- datos del upload del contrato


   REG_PROCESOS.pku_gestor_cont_utiles_2.p_last_upload_prorroga( ag_cod_contrato, session__N_CONVOCA, ln_NCOD_DOC,lv_DOC_URL,lv_FEC_UPLOAD ,lv_USER_UPLOAD,lv_FEC_APROB ,lv_EXT_TIPO_FILE,lv_ICON_TIPO_FILE, lv_DOC_OBS,ag_cod_contrato);


 -----aramirez----  DATOS DEL UPLOAD 
 usp_print
     ('
  <div>
  <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
    ');

usp_print( '<tr align=center> <td class=c1>Archivo del Contrato Complementario </td> <td colspan="4" align=center>' || case when lv_DOC_URL is not null then '<br><a target=_blank href="DownloadFileServlet?fileName='||lv_DOC_URL||'">
                <img src="'||lv_ICON_TIPO_FILE||'" border="0" width="25" height="25"/></a>' 
                end || case when lv_FEC_UPLOAD is not null then ' Registrado el '||lv_FEC_UPLOAD end||'<input type="hidden" name="pfiletoupload_file1" value=""/>

          </td>
          </tr>');

    usp_print
     ('

  </table>
    </div>');

 ---aramirez fin  */



  IF(ln_ind_siaf = 1) THEN
     usp_print('
     <div style="width:100%; text-align:left">
       <table width=40% id=cal_idtablex class="cTableCalendarioPago">
          <tr><td><h3>Calendario</h3></td></tr>
          <tr><td align=center colspan=3>');
          usp_print(lv_trama_calendario);
           --reg_procesos.pku_ss_funciones_js3.fXmlCalendario(lv_codmoneda_contrato,lv_trama_calendario,'an_total_calendario');
     usp_print('</TD></tr>
         </table>
      </div> ');
  END IF;


  usp_print('<script>
    $(document).ready(function(){


     var total = 0;
 $("#idBotonAgregarCalendario").on("click", function(){

      var mont = $(this).parent().parent().children().eq("2").children().val();
      var fec = $(this).parent().parent().children().eq("1").children().children(".fecCalendar").val();
      total = total+ parseFloat(mont);  
      thisform.an_total_calendario.value = total;
      if(mont !== "" && fec !==""){
              $(''.cTableCalendarioPago tr:last'').after("<tr class=''cFilaCalendario''>"+
                              "<td style=''text-align:center'' class=rowIndexCalendario></td>"+
                              "<td><div class=''input-group datepicker''  id=''idDivTxtFechaIni''><div class=''input-group-addon add-on''><span class=''glyphicon glyphicon-calendar''></span></div><input type=''text'' readonly name=''ag_cal_fec_pago'' value=''"+fec+"'' style=''width:98%'' data-format=''dd/MM/yyyy'' class=''form-control fecCalendar''/></div></td>"+                              
                              "<td><input class=''cag_cal_monto_pago'' name=''ag_cal_monto_pago'' value=''"+mont+"'' type=text onKeyPress=''f_validaCampoNumerico();'' onBlur=''this.value = redondear(this.value,2); calculaTotalCalendario()'' /></td>"+ 
                              "<td align=center><img onclick=''deleteRowCalendario(this)'' title=''Elimnar'' src=''img/eliminar.gif'' style=''cursor:pointer''/></td>"+                              
                              "</tr>");
                              $(this).parent().parent().children().eq("2").children().val('''');
                              $(this).parent().parent().children().eq("1").children().children(".fecCalendar").val('''');
                              enumeraItemCalendario();
                              calculaTotalCalendario();
   }});

      function enumeraItemCalendario(){
       var i = 0;
       $(".rowIndexCalendario").each(function(){
           i++;
           $(this).text(i);
       })}

      function deleteRowCalendario(indice){
        tableId = document.getElementById("cal_idtablex");
        rest = indice.parentNode.parentNode.childNodes.item(2).childNodes.item(0).value;
        tableId.deleteRow(indice.parentNode.parentNode.rowIndex);
        enumeraItemCalendario();
        calculaTotalCalendario();
      }

     function calculaTotalCalendario(){
        var total = 0;
        $(".cag_cal_monto_pago").each(function(){
             total = total + parseFloat($(this).val());                                  
        });
        $("#idSumTotal").text(total);
        thisform.an_total_calendario.value = total;
      }

     function generacionTramaCalendario(){
        var xmlCalendario = "";
        xmlCalendario = xmlCalendario+"<root>";
        $(".cFilaCalendario").each(function(){
        xmlCalendario = xmlCalendario+"<calendario>"+
        "<fecha>"+$(this).children().eq(''1'').children().children(''.fecCalendar'').val()+"</fecha>"+
        "<monto>"+$(this).children().eq(''2'').children().val()+"</monto>"+         
        "<control></control>"+                  
        "<id></id>"+         
        "<moneda></moneda>"+
        "<numpago>"+$(this).children().eq(''0'').text()+"</numpago>"+
                      "</calendario>"    
       });
       xmlCalendario = xmlCalendario+"</root>";  
       thisform.ag_trama_calendario.value = xmlCalendario;
     }

   function f_validaCampoNumerico()
    {
        escribe=1;
        var key=window.event.keyCode;            //codigo de tecla.
        if (key <46 || key > 57 || key==47){     //si no es numero o punto decimal "."
            window.event.keyCode=0;                  //anula la entrada de texto.
        }
    }
    }); 
     </script>');

     ------- Mostrar Items Seleccionados --------

  IF lv_trama_items IS NOT NULL  THEN
    usp_print('<br>
              <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>');
    usp_print('<tr><td><h3>Items</h3></td></tr>');
    usp_print('<tr align=center>');
    usp_print('<TD colspan="4" align=center>');
    PKU_GESTOR_CONT_FUNCIONES_JS_3.fXmlItemsReader(lv_trama_items,'an_total_items');
    usp_print('</TD></TR>');
    usp_print('</table>');
  END IF;

     ----------------- Java Script --------------
  usp_print('
 <script language="javascript">

 var sumaTotal = 0;

 function cancelar(obj,cantItems){
         thisform.scriptdo.value="LisProrrogasDoView";
         thisform.submit();
         return true;
  }

  function validar_rnp(obj){
    if(thisform.ag_cod_operacion.value==6){
       thisform.scriptdo.value="ValRNPProrrogaDoView";
       thisform.submit();
    }
    return true;
  }

  function seleccionaritems(){
    try{
           xmlDelEliminar(xmlCalendario);
           thisform.ag_trama_calendario.value = xmlCalendario.xml;
    } catch(e){}

    thisform.scriptdo.value="NewProItemDoEdit";
    thisform.submit();

  }

 function validarFechaMonto()
     {
        var dif_dias;

        if(ValidarBlanco(thisform.ag_f_contrato,"la Fecha de la Prorroga o Contrato Complementario") && ValidarBlanco(thisform.ag_f_culminacion,"la Fecha de Culminacion de la Prorroga o Contrato Complementario"))
        {
             if(thisform.ag_f_contrato.value == thisform.ag_f_culminacion.value){
                  alert("La fecha de la prorroga o Contrato Complementario y la fecha de culminacion no pueden ser iguales")
                  thisform.ag_f_contrato.focus();
                  return false;
             }
        }
        else {
                return false;
        }

        // Validar Prorroga
        /*if(thisform.ag_cod_operacion.value==2){
               if (parseFloat(thisform.ag_cont_dias.value) + parseFloat(thisform.ag_plazo.value) > 360){
                  alert("Solo se pueden realizar prorrogas por un maximo de 3 a?os");
                  return false;
               }
          }*/

       // Validar Complementario
       if(thisform.ag_cod_operacion.value==6){

             dif_dias    = diasEntre(thisform.ag_f_vigencia_fin.value,thisform.ag_f_contrato.value);

             if (dif_dias <= 0) {
                alert("La fecha del Contrato Complementario, debe ser posterior al fin de vigencia del Contrato")
                return false;
              }
             if (dif_dias > 0 && dif_dias > 90 ){
                alert("El contrato complementario se debe realizar dentro de los tres meses posteriores a la culminacion del Contrato")
                return false;
              }
      }
      return true;
  }

  function calculaTotalCalendario(){
        var total = 0;
        $(".cag_cal_monto_pago").each(function(){
             total = total + parseFloat($(this).val());                                  
        });
        $("#idSumTotal").text(total);
        thisform.an_total_calendario.value = total;
      }

      function generacionTramaCalendario(){
        var xmlCalendario = "";
        xmlCalendario = xmlCalendario+"<root>";
        $(".cFilaCalendario").each(function(){
        xmlCalendario = xmlCalendario+"<calendario>"+
        "<fecha>"+$(this).children().eq(''1'').children().children(''.fecCalendar'').val()+"</fecha>"+
        "<monto>"+$(this).children().eq(''2'').children().val()+"</monto>"+         
        "<control></control>"+                  
        "<id></id>"+         
        "<moneda></moneda>"+
        "<numpago>"+$(this).children().eq(''0'').text()+"</numpago>"+
                      "</calendario>"    
       });
       xmlCalendario = xmlCalendario+"</root>";  
       thisform.ag_trama_calendario.value = xmlCalendario;
     }


  function validarMonto(){
      if (thisform.ag_ind_siaf.value == 1){
         if(thisform.an_total_calendario.value == 0 ){
              alert("Debe registrar el cronograma de pagos");
             // thisform.ag_cal_monto_pago.focus();
              return false;
         }
      }

      if(thisform.an_total_items.value == ""){
              alert("Debe seleccionar al menos un item para continuar");
              return false;
      }

      if (thisform.an_total_calendario.value != thisform.an_total_items.value){
          alert("La suma de los montos en el Calendario de pago no coincide con el monto contratado, corrija e intente nuevamente")
          thisform.ag_cal_monto_pago.focus();
          return false;
      }

      return true;
  }

  function grabar()
  {
      calculaTotalCalendario();
      if (!ValidarBlanco(thisform.ag_n_contrato,"Numero del Contrato Complementario o Prorroga")){
            return false;
       }

      if (!ValidarBlanco(thisform.ag_des_contrato,"la Descripcion del Contrato Complementario o Prorroga")){
            return false;
       }

      if (!ValidarBlanco(thisform.ag_des_causa_renov,"la Causa del Contrato Complementario o Prorroga")){
            return false;
       }

      if(!validarMonto())
      {
         return false;
      }

      if(!validarFechaMonto())
      {
         return false;
      }

      //thisform.ag_trama_items.value = xmlItems.xml;
      //thisform.ag_trama_calendario.value = xmlCalendario.xml;
      generacionTramaCalendario();
      thisform.ag_cod_contrato_ren.value=thisform.ag_cod_contrato.value;
      thisform.scriptdo.value="ProrrogaDoUpdate";
     // thisform.submit();
      return true;
  }


  function validar_rnp(obj)
  {
      if(thisform.ag_cod_operacion.value==6)
      {
      thisform.scriptdo.value="ValRNPProrrogaDoView";
      thisform.submit();
      }
      return true;
  }


       </script>
     ');

     usp_print('<script language="javascript">
     try{
         thisform.ag_m_contratado.value= redondear(parseFloat(sumaTotalesItems(xmlItems)),2);

      }catch(err){
      }

       </script>
     ');

  END;

  /********************************************************/
  PROCEDURE uspProrrogaDoUpdate
     ( ag_id_usuario           varchar2,
       ag_n_convoca            varchar2,
       ag_cod_contrato         varchar2,
       ag_cod_contrato_ren     varchar2,
       ag_n_contrato           varchar2,
       ag_cod_moneda           varchar2,
       ag_f_contrato           varchar2,
       ag_m_contratado         varchar2,
       ag_des_causa_renov      varchar2,
       ag_des_contrato         varchar2,
       ag_plazo                varchar2,
       ag_f_culminacion        varchar2,
       ag_cod_operacion        varchar2,
       ag_ncor_orden_pedido    varchar2,
       ag_ind_siaf             varchar2,
       ag_ind_consorcio        varchar2,
       ag_ruc_contratista      varchar2,
       session__N_CONVOCA   varchar2,
       ag_trama_calendario     varchar2,
       ag_trama_items          varchar2
       ) Is


   ----------- Variables ---------
   ln_cod_contrato_ren     number;
   ln_cod_contrato         number;
   ln_n_convoca            number;
   ln_ind_siaf             number;
   ld_f_contrato           date;
   ln_m_contratado         number;
   lv_des_causa_renov      varchar2(1000);
   lv_des_contrato         varchar2(500);
   ln_plazo                number;
   ld_f_culminacion        date;
   ln_cod_operacion_cont   number;
   ls_result_valrnp        varchar2(2000);
   lb_validacion_rnp               BOOLEAN;
   lv_estado_rnp                   VARCHAR2(500);

   Begin


     ln_cod_contrato            := ag_cod_contrato;
     ln_n_convoca               := session__N_CONVOCA ;
     ln_cod_contrato_ren        := to_number(ag_cod_contrato_ren);
     ln_ind_siaf                := to_number(ag_ind_siaf);
     ln_m_contratado            := to_number(ag_m_contratado);
     lv_des_causa_renov         := trim(ag_des_causa_renov);
     lv_des_contrato            := trim(ag_des_contrato);
     ln_plazo                   := to_number(ag_plazo);



     if (ag_f_contrato is not null) then
         ld_f_contrato:= to_date(ag_f_contrato,REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_fecha);
     else
         ld_f_contrato:= Null;
     end if;

     if (ag_f_culminacion is not null) then
         ld_f_culminacion:= to_date(ag_f_culminacion,REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_fecha);
     else
         ld_f_culminacion:= Null;
     end if;

     ln_cod_operacion_cont:= to_number(ag_cod_operacion);


     --------------------- Hiddens -------------------------------
    usp_print('
        <input type="hidden"  name ="ag_cod_contrato_ren"               value="'||ln_cod_contrato_ren||'" />
        <input type="hidden"  name ="ag_n_contrato"                     value="'||ag_n_contrato||'" />
        <input type="hidden"  name ="ag_cod_moneda"                     value="'||ag_cod_moneda||'" />
        <input type="hidden"  name ="ag_codmoneda_contrato"             value="'||ag_cod_moneda||'" />
        <input type="hidden"  name ="ag_des_contrato"                   value="'||ag_des_contrato||'" />
        <input type="hidden"  name ="ag_des_causa_renov"                value="'||ag_des_causa_renov||'" />
        <input type="hidden"  name ="ag_plazo"                          value="'||ln_plazo||'" />
        <input type="hidden"  name ="ag_f_culminacion"                  value="'||ag_f_culminacion||'" />
        <input type="hidden"  name ="ag_f_contrato"                     value="'||ag_f_contrato||'" />
        <input type="hidden"  name ="ag_cod_operacion"                  value="'||ln_cod_operacion_cont||'" />
        <input type="hidden"  name ="ag_id_usuario"                     value="'||ag_id_usuario||'" />
        <input type="hidden"  name ="ag_n_convoca"                      value="'||ag_n_convoca||'" />
        <input type="hidden"  name ="ag_ncor_orden_pedido"              value="'||ag_ncor_orden_pedido||'" />
        <input type="hidden"  name ="ag_cm_opc" />
        <input type="hidden"  name ="ag_cm_oper_compra" />
     ');


        /*Inicio 003-sm*/

               select * into consucode2,proveedor2,proceso2,nconvoca2,fcontra2,npropuesta2 from table(f_get_emp_dets(session_cod_contrato2));

         if (consucode2='002433' and proceso2='SEL') or (consucode2='002433' and proceso2='ABR') or (consucode2='002433' and proceso2='COM') then

                   lb_validacion_rnp3 := f_valida_rnp_contrato(proveedor2,nconvoca2,ag_f_contrato,npropuesta2,lb_estado_inha2);
                      if  lb_validacion_rnp3 then

                                              ---------- Actualizar Contrato -----------
                         Update REG_PROCESOS.contrato set
                                  n_contrato                    = ag_n_contrato,
                                  f_contrato                    = ld_f_contrato,
                                  m_contratado                  = ln_m_contratado,
                                  des_causa_renovacion          = lv_des_causa_renov,
                                  des_contrato                  = lv_des_contrato,
                                  plazo                         = ln_plazo,
                                  f_culminacion                 = ld_f_culminacion
                            where n_cod_contrato                = ln_cod_contrato;

                         ---------- Insertar Items Prorrogados --------
                    /*     usp_print('Se actualizo..</br>');
                         usp_print('ln_cod_contrato: '||ln_cod_contrato||'<br>');
                         usp_print('ln_n_convoca: '||ln_n_convoca||'<br>');
                         usp_print('ln_cod_contrato_ren: '||ln_cod_contrato_ren||'<br>');
                         usp_print('ln_ind_siaf: '||ln_ind_siaf||'<br>');
                         usp_print('ln_m_contratado: '||ln_m_contratado||'<br>');
                         usp_print('lv_des_causa_renov: '||lv_des_causa_renov||'<br>');
                         usp_print('lv_des_contrato: '||lv_des_contrato||'<br>');
                         usp_print('ln_plazo: '||ln_plazo||'<br>');
                         usp_print('ld_f_contrato: '||ag_f_contrato||'<br>');
                         return; */
                         usp_registra_items(ag_trama_items,ag_cod_contrato,ln_n_convoca);

                        ---------- Grabar Calendario de Pagos ----------
                        if ln_ind_siaf = 1 then
                         usp_registra_calendario(ag_trama_calendario);
                        end if;

                        ----------- Actualiza la Ultima Operacion del Contrato ----
                        update REG_PROCESOS.contrato  set
                               ID_OPERACION = REG_PROCESOS.PK_CONVOCATORIA.getidoperacion()
                        where n_cod_contrato = ln_cod_contrato;

                        ----------- Actualiza el Costo Final ---------
                    /*    reg_procesos.pku_ss_make_contrato.usp_calcula_costoFinal(ln_cod_contrato_ren);
                    */
                        ----------- Transfiere al MEF ------------
                        ----------- Si es complementario se transfiere al MEF -----------
                    --    if (ln_cod_operacion_cont = 6) then
                    --        REG_PROCESOS.PK_TRANS_MEF.SP_WS_MEF_SEND_OPERACION(REG_PROCESOS.PK_CONVOCATORIA.getidoperacion());
                    --    elsif (ln_codobjeto != 1) then
                        ----------- Si es Prorroga y el objeto no es Bienes se transfiere al MEF -----------
                        REG_PROCESOS.PK_TRANS_MEF.SP_WS_MEF_SEND_OPERACION(REG_PROCESOS.PK_CONVOCATORIA.getidoperacion());
                    --    end if;

                        commit;

                        usp_print('
                          <script language=javascript>
                            thisform.scriptdo.value = "LisProrrogasDoView";
                            thisform.submit();
                          </script>');
                   --
                   else 
                            begin   

                                 if lb_error2 then
                                       usp_print('
                                   <script language=javascript>
                                    alert("Sistema externo no disponible, vuelva a intentar");
                                     thisform.scriptdo.value = "NewProrrogaDoEdit";
                                     thisform.submit();
                                   </script>
                                   ');
                                   return;

                                 else

                                   usp_print('
                                   <script language=javascript>
                                     alert("El proveedor'||' '|| proveedor2 ||' '||'se encuentra inhabilitado, no es posible publicar el contrato");
                                     thisform.scriptdo.value = "NewProrrogaDoEdit";
                                     thisform.submit();
                                   </script>
                                   ');
                                   return;

                                   end if;
                             end;
                        end if;

             else 

              -------------------- Validar Vigencia RNP ------------------------------
     if (ln_cod_operacion_cont = 6) then --- Complementario---
         if (ag_n_convoca is not null ) then
          if ( substr(ag_ruc_contratista,1,1) not in ('7','I')  /*or ln_proc_tipo <> 23*/ )then

                lb_validacion_rnp := reg_procesos.pku_ss_mod_contratos.F_VALIDA_RNP_CONTRATO(ag_ruc_contratista, ag_n_convoca,ag_f_contrato, lv_estado_rnp);


                IF NOT lb_validacion_rnp THEN
                   reg_procesos.pku_ss_mod_contratos.f_msg_pantalla(lv_estado_rnp,'''NewProrrogaDoEdit''');
                   reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_3.js_script(' _error = 1; ');
                   return;
                END IF;

            END IF;
          /*   ls_result_valrnp:= reg_procesos.F_VALIDA_CONT_RNP(
                                ag_n_convoca, ag_ind_consorcio,
                                ag_ruc_contratista,
                                null, ag_f_contrato);

             if (ls_result_valrnp is not null) then
                 if (substr(ls_result_valrnp,1,1) != 1) then -- RUC No esta Vigente ---
                     begin
                           usp_print('
                           <script language=javascript>
                             alert("El Proveedor no cuenta con inscripcion vigente en el RNP \n       o esta inhabilitado para contratar con el estado");
                             thisform.scriptdo.value = "ManProrrogaDoEdit";
                             thisform.submit();
                           </script>
                           ');
                           return;

                     end;
                 end if;
             end if;*/
         end if;
     end if;



     ---------- Actualizar Contrato -----------
     Update REG_PROCESOS.contrato set
              n_contrato                    = ag_n_contrato,
              f_contrato                    = ld_f_contrato,
              m_contratado                  = ln_m_contratado,
              des_causa_renovacion          = lv_des_causa_renov,
              des_contrato                  = lv_des_contrato,
              plazo                         = ln_plazo,
              f_culminacion                 = ld_f_culminacion
        where n_cod_contrato                = ln_cod_contrato;

     ---------- Insertar Items Prorrogados --------
/*     usp_print('Se actualizo..</br>');
     usp_print('ln_cod_contrato: '||ln_cod_contrato||'<br>');
     usp_print('ln_n_convoca: '||ln_n_convoca||'<br>');
     usp_print('ln_cod_contrato_ren: '||ln_cod_contrato_ren||'<br>');
     usp_print('ln_ind_siaf: '||ln_ind_siaf||'<br>');
     usp_print('ln_m_contratado: '||ln_m_contratado||'<br>');
     usp_print('lv_des_causa_renov: '||lv_des_causa_renov||'<br>');
     usp_print('lv_des_contrato: '||lv_des_contrato||'<br>');
     usp_print('ln_plazo: '||ln_plazo||'<br>');
     usp_print('ld_f_contrato: '||ag_f_contrato||'<br>');
     return; */
     usp_registra_items(ag_trama_items,ag_cod_contrato,ln_n_convoca);

    ---------- Grabar Calendario de Pagos ----------
    if ln_ind_siaf = 1 then
     usp_registra_calendario(ag_trama_calendario);
    end if;

    ----------- Actualiza la Ultima Operacion del Contrato ----
    update REG_PROCESOS.contrato  set
           ID_OPERACION = REG_PROCESOS.PK_CONVOCATORIA.getidoperacion()
    where n_cod_contrato = ln_cod_contrato;

    ----------- Actualiza el Costo Final ---------
/*    reg_procesos.pku_ss_make_contrato.usp_calcula_costoFinal(ln_cod_contrato_ren);
*/
    ----------- Transfiere al MEF ------------
    ----------- Si es complementario se transfiere al MEF -----------
--    if (ln_cod_operacion_cont = 6) then
--        REG_PROCESOS.PK_TRANS_MEF.SP_WS_MEF_SEND_OPERACION(REG_PROCESOS.PK_CONVOCATORIA.getidoperacion());
--    elsif (ln_codobjeto != 1) then
    ----------- Si es Prorroga y el objeto no es Bienes se transfiere al MEF -----------
    REG_PROCESOS.PK_TRANS_MEF.SP_WS_MEF_SEND_OPERACION(REG_PROCESOS.PK_CONVOCATORIA.getidoperacion());
--    end if;

    commit;

    usp_print('
      <script language=javascript>
        thisform.scriptdo.value = "LisProrrogasDoView";
        thisform.submit();
      </script>');


  end if;

        /*fin 003-sm*/

   End;


END PKU_GESTOR_CONT_COMPLEMENT;
/
