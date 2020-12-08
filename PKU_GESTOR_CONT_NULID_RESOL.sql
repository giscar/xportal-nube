set scan off;
CREATE OR REPLACE PACKAGE "PKU_GESTOR_CONT_NULID_RESOL" is

--consultoria nube migracion
  url_azure_app    varchar2(250):= 'https://zonasegura2.seace.gob.pe/documentos/';

  type ref_cursor is ref cursor;

  gpk_directorio_resolucion       varchar2(50):= 'mon\docs\contratos';
  gpk_eliminar                    varchar2(200):='img/eliminar.gif';
  gpk_aceptar                     varchar2(200):='img/aceptar.gif';   



PROCEDURE uspTmpContCalDoDelete(
    ag_id_usuario           varchar2,
    ag_id_motivo            varchar2,
    ag_id_operacion         varchar2,
    ag_id_op                varchar2,
    ag_num_pago             varchar2,
    ag_n_convoca            varchar2,
    ag_cod_contrato         varchar2,
    ag_eue_codigo           varchar2,
    ag_cod_tipo_resoucion   varchar2,
    ag_fec_resolucion       varchar2,
    ag_cod_causa_resolucion varchar2,
    ag_reg_cal_modif        varchar2,
    ag_anhoentidad          varchar2,
    ag_proc_tipo            varchar2,
    ag_proc_desc            varchar2,
    ag_proc_sigla           varchar2,
    ag_currenpage           varchar2,
    session__userid         varchar2,
    av_envento              varchar2);


PROCEDURE uspResolucionDoInsert(
    session__N_CONVOCA             varchar2,
    session__COD_CONTRATO          varchar2,
    ag_cod_moneda                  varchar2,
    ag_cod_tipo_resoucion          varchar2,
    ag_cod_causa_resolucion        varchar2,
    ag_fec_resolucion              varchar2,
    ag_ind_siaf                    varchar2,
    ag_cadena_items                varchar2,
    ag_operacion                   number,
    session__userid                varchar2,
    ag_doc_resolucion              varchar2,
    pfiletoupload1                        varchar2,
    pfiletoupload_file1                        varchar2,
    --ag_file__size                  varchar2,
    --ag_file__mimetype              varchar2,
    WriteFileDirectoryDynamic      varchar2,
    iisenv__remote_host            varchar2,
    session__FileSingedHTTP        varchar2
);

PROCEDURE uspTmpContCalDoUpdate(
      session__userid         varchar2,
      ag_id_motivo            varchar2,
      ag_id_operacion         varchar2,
      ag_id_op                varchar2,
      ag_num_pago             varchar2,
      ag_fec_pago             varchar2,
      ag_monto_pago           varchar2,
      ag_cod_contrato         varchar2,
      ag_eue_codigo           varchar2,
      ag_cod_tipo_resoucion   varchar2,
      ag_fec_resolucion       varchar2,
      ag_cod_causa_resolucion varchar2,
      ag_reg_cal_modif        varchar2,
      ls_cod_tipo_operacion   varchar2);

FUNCTION f_contrato_transferido(
    ag_n_cod_contrato  varchar2
    ) return number ;

PROCEDURE uspNewAnulacionesDoEdit(
    ag_n_convoca            varchar2 DEFAULT Null,
    session__N_CONVOCA      varchar2,
    session__COD_CONTRATO   varchar2 DEFAULT Null,
    ag_cod_tipo_resoucion   varchar2 DEFAULT Null,
    ag_fec_resolucion       varchar2 DEFAULT Null,
    ag_cod_causa_resolucion varchar2 DEFAULT Null,
    ag_reg_cal_modif        varchar2 DEFAULT Null,
    ag_anhoentidad          varchar2 DEFAULT Null,
    session__userid         varchar2);

PROCEDURE uspNewResolucionDoEdit(
    ag_cod_tipo_resoucion       varchar2,
    ag_fec_resolucion           varchar2,
    ag_cod_causa_resolucion     varchar2,
    ag_reg_cal_modif            varchar2,
    ag_cm_opc                   varchar2,
    session__N_CONVOCA          varchar2,
    session__COD_CONTRATO       varchar2,
    session__userid             varchar2,    
    ag_doc_resolucion           varchar2,
    ls_cod_tipo_operacion       varchar2);


 PROCEDURE uspLisResolucionDoView(
    session__userid             varchar2,
    session__N_CONVOCA          varchar2,
    session__COD_CONTRATO       varchar2,
    session__PUBLICADO          varchar2);


  PROCEDURE uspManResolucionDoView(
      session__N_CONVOCA         varchar2,
      ag_cod_resolucion    varchar2,
      ag_anhoentidad       varchar2,
      ag_proc_tipo         varchar2,
      ag_proc_desc         varchar2,
      ag_proc_sigla        varchar2,
      session__FileSingedHTTP  varchar2);    

  PROCEDURE uspResolucionDoCancel(
    session__userid         varchar2);

end PKU_GESTOR_CONT_NULID_RESOL;

/


CREATE OR REPLACE PACKAGE BODY                "PKU_GESTOR_CONT_NULID_RESOL" is

FUNCTION f_contrato_transferido(
    ag_n_cod_contrato  varchar2
    ) return number Is
    ----------------------
    ln_cont_transf number;
    ln_total       number;
Begin
    select count(1) into ln_total
    from reg_procesos.contrato_operacion a
    where
        a.n_cod_contrato = ag_n_cod_contrato
        and a.cod_estado_transferencia = 10;

    if ln_total > 0 then
        ln_cont_transf:= 1; --- Ya tiene transferencias
    else
        ln_cont_transf:= 0; --- No tiene transferencias
    end if;

    return ln_cont_transf;
End;




/**********************************************************************/
PROCEDURE uspTmpContCalDoDelete(
    ag_id_usuario           varchar2,
    ag_id_motivo            varchar2,
    ag_id_operacion         varchar2,
    ag_id_op                varchar2,
    ag_num_pago             varchar2,
    ag_n_convoca            varchar2,
    ag_cod_contrato         varchar2,
    ag_eue_codigo           varchar2,
    ag_cod_tipo_resoucion   varchar2,
    ag_fec_resolucion       varchar2,
    ag_cod_causa_resolucion varchar2,
    ag_reg_cal_modif        varchar2,
    ag_anhoentidad          varchar2,
    ag_proc_tipo            varchar2,
    ag_proc_desc            varchar2,
    ag_proc_sigla           varchar2,
    ag_currenpage           varchar2,
    session__userid         varchar2,
    av_envento              varchar2)
Is
    -------- Variables -------
    ln_existe_reg  number;
Begin

    if (session__userid is null) then
     usp_print('<h2>Su Sesion ha expirado... Por favor, vuelva a loguearse.</h2>');
     return;
    end if;

    Select count(1) into ln_existe_reg
    from reg_procesos.tmp_contrato_operacion_cal a
    where
        a.id_usuario = trim(ag_id_usuario)
        and a.id_motivo = to_number(ag_id_motivo)
        and a.id_operacion = to_number(ag_id_operacion)
        and a.num_pago = to_number(ag_num_pago)
        and a.id_op = to_number(ag_id_op);

    if ln_existe_reg > 0 then
        Update reg_procesos.tmp_contrato_operacion_cal
        set ind_eliminar = 1
        where
            id_usuario = trim(ag_id_usuario)
            and id_motivo = to_number(ag_id_motivo)
            and id_operacion = to_number(ag_id_operacion)
            and num_pago = to_number(ag_num_pago)
            and id_op = to_number(ag_id_op);
    else
        Insert into reg_procesos.tmp_contrato_operacion_cal
        (id_usuario,id_motivo,id_operacion,id_op,
         num_pago, d_fec_registro,ind_eliminar)
        values
        (trim(ag_id_usuario),to_number(ag_id_motivo),
         to_number(ag_id_operacion), to_number(ag_id_op),
         to_number(ag_num_pago), sysdate,1);
    end if;
    commit;

    ----------------------------------------------------
    usp_print('
    <input type="hidden" name ="ag_id_usuario"           value="'||ag_id_usuario||'"/>
    <input type="hidden" name ="ag_n_convoca"            value="'||ag_n_convoca||'"/>
    <input type="hidden" name ="ag_cod_contrato"         value="'||ag_cod_contrato||'"/>
    <input type="hidden" name ="ag_eue_codigo"           value="'||ag_eue_codigo||'"/>
    <input type="hidden" name ="ag_cod_tipo_resoucion"   value="'||ag_cod_tipo_resoucion||'"/>
    <input type="hidden" name ="ag_fec_resolucion"       value="'||ag_fec_resolucion||'"/>
    <input type="hidden" name ="ag_cod_causa_resolucion" value="'||ag_cod_causa_resolucion||'"/>
    <input type="hidden" name ="ag_reg_cal_modif"        value="'||ag_reg_cal_modif||'"/>
    <input type="hidden" name="ag_anhoentidad"           value="'||ag_anhoentidad||'"/>
    <input type="hidden" name="ag_proc_tipo"             value="'||ag_proc_tipo||'"/>
    <input type="hidden" name="ag_proc_desc"             value="'||ag_proc_desc||'"/>
    <input type="hidden" name="ag_proc_sigla"            value="'||ag_proc_sigla||'"/>
    <input type="hidden" name="ag_currenpage"            value="'||ag_currenpage||'"/>

    <script language="javascript">
        thisform.scriptdo.value = "'||av_envento||'";
        thisform.submit();
    </script>
    ');
End;

PROCEDURE uspNewAnulacionesDoEdit(
    ag_n_convoca            varchar2 DEFAULT Null,
    session__N_CONVOCA      varchar2,
    session__COD_CONTRATO   varchar2 DEFAULT Null,
    ag_cod_tipo_resoucion   varchar2 DEFAULT Null,
    ag_fec_resolucion       varchar2 DEFAULT Null,
    ag_cod_causa_resolucion varchar2 DEFAULT Null,
    ag_reg_cal_modif        varchar2 DEFAULT Null,
    ag_anhoentidad          varchar2 DEFAULT Null,
    session__userid         varchar2
    )
IS
        --------- Operaciones --------------
    Cursor c_oper(p_n_cod_contrato in number) is
    Select
        1 id_motivo, 'Contrato' des_motivo, c.n_cod_contrato id_op,
        to_char(c.f_contrato,'dd/mm/yyyy') f_operacion, id_operacion
    from reg_procesos.contrato c
    where c.n_cod_contrato = p_n_cod_contrato
  /*  union
        Select
        4 id_motivo, 'Contrato Complementario' des_motivo, c.n_cod_contrato id_op,
        to_char(c.f_contrato,'dd/mm/yyyy') f_operacion, id_operacion
    from reg_procesos.contrato c
    where c.n_cod_contrato_de_renovac = p_n_cod_contrato
    and cod_operacion_contrato = 6
    */
    order by 1;

    ------- Calendario de cada operacion -------
    Cursor c_cal(p_id_operacion in number, p_id_op in number, p_id_motivo in number, p_id_usuario in varchar2) is
    Select
        a.num_pago, a.codmoneda, to_char(a.fec_pago,'dd/mm/yyyy') fec_prog,
        a.monto_pago  monto_prog, nvl(b.fec_pago,to_char(a.fec_pago,'dd/mm/yyyy')) fec_pago,
        nvl(b.monto_pago,a.monto_pago) monto_pago, b.ind_eliminar
    from
        reg_procesos.contrato_operacion_calendario a,
        (   Select x.id_operacion, x.num_pago, x.fec_pago, x.monto_pago, x.ind_eliminar
            from reg_procesos.tmp_contrato_operacion_cal x
            where id_usuario = p_id_usuario and id_motivo = p_id_motivo and id_op = p_id_op
         ) b
    where
        a.id_operacion = b.id_operacion(+)
        and a.num_pago = b.num_pago(+)
        and a.id_operacion = p_id_operacion;


    ------------ Items del Contrato ----------------
    Cursor c_item_cont(p_n_cod_contrato in number) is
        select c.n_cod_contrato,
        ic.descripcion, i.n_convoca,
        i.proc_item,
         to_char(i.monto,REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_dinero) monto,
        i.f_registro, i.f_ult_mod, i.n_cod_resolucion, i.cantidad, i.unm_codigo
        from contrato c
        inner join reg_procesos.item_contrato i
        on c.n_cod_contrato = i.n_cod_contrato
        inner join reg_procesos.item_convoca ic
        on i.n_convoca = ic.n_convoca
        and i.proc_item = ic.proc_item
        where 
        (c.n_cod_contrato = p_n_cod_contrato 
         /*or (c.n_cod_contrato_de_renovac = p_n_cod_contrato and c.cod_operacion_contrato = 6)*/
        );

    ------- Variables ------
    e_ArgumentosMalos       exception;
    lv_eue_codigo           varchar2(6);
    lv_anhoentidad          varchar2(4);
    ln_n_convoca            varchar2(7);
    lv_proc_sigla           varchar2(60);
    lv_proc_tipo_sigla      varchar2(20);
    lv_proc_num             varchar2(15);
    ln_proc_tipo            number;
    ln_n_proceso            number;
    ln_cod_contrato         number;
    lv_n_contrato           REG_PROCESOS.contrato.n_contrato%type;
    ln_cant_tipo            number;
    ln_ind_uso_siaf         number;
    ln_cont_pagos           number;
    ln_fila                 number;
    lv_total_pago_cont_src  varchar2(20);
    lv_total_progr_op       varchar2(20);
    lv_total_pagar_op       varchar2(20);
    lv_id_usuario           varchar2(30);
    ln_ncor_orden_pedido    number;
    ln_contr_trans          number;
    ln_cadena               varchar(5000);
    lvdirectorio            varchar2(50);
    lv_ruta_file            varchar2(250);   

    lv_combo_tipoAlcance    varchar2(4000);
    lv_combo_tipoResolucion varchar2(4000);
    lv_combo_tipoResolucion2 varchar2(4000);  

    ctipoAlcance            ref_cursor;
    ctipoResolucion         ref_cursor;
    ctipoResolucion2        ref_cursor;

BEGIN



    ctipoAlcance             :=  PKU_SS_UTILES.f_ctipo_causa(2);
    ctipoResolucion          :=  PKU_SS_UTILES.f_ctipo_resolucion(null);
    ctipoResolucion2         :=  PKU_SS_UTILES.f_ctipo_resolucion(2);

    -- Inicializamos los combos
    lv_combo_tipoAlcance     := PKU_SS_UTILES.f_retorna_combo(ctipoAlcance, 'ag_cod_causa_resolucion', ag_cod_causa_resolucion,'Seleccione causal ...','style="width:99%"');
    lv_combo_tipoResolucion  := PKU_SS_UTILES.f_retorna_combo(ctipoResolucion, 'ag_cod_tipo_resoucion', ag_cod_tipo_resoucion,'Seleccione alcance ...','onchange="Refresh(this);" style="width:99%"');
    lv_combo_tipoResolucion2 := PKU_SS_UTILES.f_retorna_combo(ctipoResolucion2, 'ag_cod_tipo_resoucion', ag_cod_tipo_resoucion,'Seleccione alcance ...','onchange="Refresh(this);" style="width:99%"');


    ln_cod_contrato    := to_number(session__COD_CONTRATO);
    --MMAUTINO: Formato 1514_OP_SEACE2_CON - No se generaba la ruta correcta
    ln_n_convoca       := to_number(session__N_CONVOCA);
    --fin
    lv_id_usuario      := session__userid;

    ------ Verificar si tiene transferencias el contrato ---
    -- ln_contr_trans:= PKU_SS_NULIDAD_RESOL.f_contrato_transferido(ln_cod_contrato);
    -- Por incidencia 127 se elimina la validacion de contrato transferido
    ln_contr_trans:= 0;

    -------- Funciones Script -------
    REG_PROCESOS.PKU_GESTOR_CONT_FUNCIONES_JS_3.fValidaCadenas_JS;

    ----- Obtener Datos de la Convocatoria-------
    IF (ln_n_convoca is not null) THEN
    begin
        Select
            co.codconsucode, co.n_proceso, co.anhoentidad, co.proc_tipo, co.proc_num, co.proc_sigla, t.proc_tipo_sigla
        into
            lv_eue_codigo, ln_n_proceso, lv_anhoentidad,ln_proc_tipo, lv_proc_num, lv_proc_sigla, lv_proc_tipo_sigla
        from
            REG_PROCESOS.convocatorias co,
            REG_PROCESOS.tipo_procesos t
        where
            t.proc_tipo = co.proc_tipo
            and co.n_convoca = ln_n_convoca;
    exception
         WHEN OTHERS THEN
                pku_ss_mod_contratos.f_msg_error('Error al intentar hallar los datos de la Convocatoria','''doViewNulidad''');

    END;

    end if;

    ----- Datos para subir el archivo

    lvdirectorio        := gpk_directorio_resolucion;
    lv_ruta_file        := lvdirectorio||'\'||lv_anhoentidad||'\'||lv_eue_codigo||'\'||ln_n_convoca;

    ----- Obtener Datos del Contrato ----
    BEGIN
        SELECT c.n_contrato INTO lv_n_contrato FROM REG_PROCESOS.contrato c WHERE c.n_cod_contrato = ln_cod_contrato;
    EXCEPTION
         WHEN OTHERS THEN
                pku_ss_mod_contratos.f_msg_error('Error al intentar hallar los datos del Contrato','''doViewNulidad''');

    END;

    usp_print('
    <input type="hidden" name="ag_n_convoca"            value="'||ln_n_convoca||'"/>
    <input type="hidden" name="ag_cod_contrato"         value="'||ln_cod_contrato||'"/>
    <input type="hidden" name="ag_id_usuario"           value="'||lv_id_usuario||'"/>
    <input type="hidden" name="ag_reg_cal_modif"        value=""/>
    <input type="hidden" name="ag_id_motivo"/>
    <input type="hidden" name="ag_id_operacion"/>
    <input type="hidden" name="ag_id_op"/>
    <input type="hidden" name="ag_num_pago"/>
    <input type="hidden" name="ag_fec_pago"/>
    <input type="hidden" name="ag_monto_pago"/>
    <input type="hidden" name="ag_cadena_items"/>
    <input type="hidden" name="ag_anhoentidad"          value="'||ag_anhoentidad||'"/>
    <input type="hidden" name="WriteFileDirectory"      value="FileSinged">
    <input type="hidden" name="extension">
    <input type="hidden" name="WriteFileDirectoryDynamic" value="'||lv_ruta_file||'" />  
    <input type="hidden" name="av_envento"    id="av_envento"  value="doNewNulidad1"    />


    <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
        <tr>');
    usp_print(
            PKU_SS_UTILES.f_get_titulo_contrato ( ln_cod_contrato, 'Nulidad / Resoluci&oacute;n del Contrato u Orden de Compra o Servicios ' ,'Nulidad / Resoluci&oacute;n del Contrato u Orden de Compra o Servicios '));
    usp_print('
            <td align="right" valign=top width="50%">');

    IF ln_contr_trans = 0 THEN
        usp_print('
                <input type="button" value="Grabar" OnClick="grabar(this,''doInsertNulidad'')"/>
        ');
    END IF;

    usp_print('
                <input type="button" value="Cancelar" OnClick="cancelar(this,''doCancelarRegistro'')"/>
            </td>
        </tr>
    </table>
    <br>');

    ------- Mostrar Mensaje si tiene transferencias -----
    IF ln_contr_trans = 1 THEN
        usp_print(
            pku_procesos_comun.f_putMensaje(
                'El Contrato ya tiene transferencias al MEF, NO puede ser resuelto.',
                '')
        );
    END IF;

    usp_print('
    <table width=100% class="table table-striped">');
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('N&uacute;mero del Contrato (u Orden de Compra o Servicio)',
                '<input type="text" name="n_contrato" readonly style="width:98%" value="'||lv_n_contrato||'"/>',
                '.'));

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Operación',
                '<SELECT name="ls_cod_tipo_operacion" onchange="TipoOperacion(this);" style="width:99%">
                    <option value = "0">Resolución de Contrato</option>
                    <option value = "1" Selected>Nulidad de Contrato</option>
                </SELECT>',
                '.'));

    --------------  Cantidad de Resoluciones ----------------
    Select count(cod_tipo_resolucion) into ln_cant_tipo from reg_procesos.contrato_resolucion where n_cod_contrato = ln_cod_contrato and cod_tipo_resolucion = 2;

    -------------- Obtener el indicador del SIAF ----------------
    begin
        select ep.ind_uso_siaf into ln_ind_uso_siaf
        from
            reg_procesos.entidadue_anho_tipo_proceso ep,
            reg_procesos.convocatorias c,
            reg_procesos.contrato cnt
        where
            ep.eue_codigo           = c.codconsucode
            and ep.eue_anho         = c.anhoentidad
            and c.n_convoca         = cnt.n_convoca
            and cnt.n_cod_contrato  = ln_cod_contrato
            and c.proc_tipo         = ep.tip_codigo;
    exception
        when no_data_found then
            ln_ind_uso_siaf:= null;
    end;

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Documento de Nulidad del Contrato',
                '<input class="form-control" name="ag_doc_resolucion" value="">',
                '.'));

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Fecha del Documento de Nulidad',
                '<div class="input-group datepicker" id="idDivTxtFechaIni">
                <div class="input-group-addon  add-on">
                     <span class="glyphicon glyphicon-calendar"></span>
                </div>
               <input type="text" name="ag_fec_resolucion" value="'||ag_fec_resolucion||'" style="width:98%" data-format="dd/MM/yyyy" class="form-control"/>
          </div>','.'));

    IF ln_cant_tipo = 0 THEN
        ln_cadena := lv_combo_tipoResolucion;
        elsif ln_cant_tipo > 0 then
        ln_cadena := lv_combo_tipoResolucion2;
    END IF;

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Alcance de la Resoluci&oacute;n',
                ln_cadena,
                '.'));                

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Causal de la Nulidad',
                lv_combo_tipoAlcance,
                '.'));

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Adjuntar Archivo',
                '<input type="file"  name="pfiletoupload1" style="width:100%"  value="">
                <input type="hidden" name="pfiletoupload_file1" value="" />',
                '.'));                

    ---------- Calendario del Contrato ----------
    IF ln_ind_uso_siaf = 1 THEN 
    BEGIN
        ------- Total Pagos Origen --------
        Select to_char(nvl(sum(a.monto_pago),0),REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_dinero) into lv_total_pago_cont_src
        from reg_procesos.contrato_operacion_calendario a 
        where a.id_operacion in ( Select id_operacion from reg_procesos.contrato c where c.n_cod_contrato =ln_cod_contrato );


        usp_print('
        <tr>
            <td class="c1">
                (*)Calendario<br/>
                ( Indique como queda el calendario despues de esta resolución conserve los montos pagados y los que se pagarán )
            </td>
            <td class="c2" colspan="2">
                <table id="cal_idtable" border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
                    <th class="th1">Operaci&oacute;n</th>
                    <th class="th1">Nro</th>
                    <th class="th1">Fecha Prog.</th>
                    <th class="th1">Monto Prog.<br/>Total: '||lv_total_pago_cont_src||'</th>
                    <th class="th1">Fecha Pago</th>
                    <th class="th1">Monto Pago<br/>Total:
                    <span id=lblMontoPago name=lblMontoPago>'||lv_total_pago_cont_src||'</span></th>');

        IF ln_contr_trans = 0 THEN -- Contrato sin transferencias --
            usp_print('
                    <th class="th1">Operaci&oacute;n</th>');
        END IF;

        ln_fila     := 1;

        ------ Operaciones del contrato -----
        For co in c_oper(ln_cod_contrato) loop
        begin
            ------- Total y Cantidad de Pagos por Operacion ----
            Select
                to_char(nvl(sum(a.monto_pago),0),REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_dinero),
                to_char(nvl(sum(decode(b.ind_eliminar,1,0,nvl(b.monto_pago,a.monto_pago))),0),REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_dinero),
                count(a.num_pago)
            into  lv_total_progr_op, lv_total_pagar_op, ln_cont_pagos
            from
                reg_procesos.contrato_operacion_calendario a,
                (   Select x.id_operacion, x.num_pago, x.fec_pago, x.monto_pago, x.ind_eliminar
                    from reg_procesos.tmp_contrato_operacion_cal x
                    where id_usuario = lv_id_usuario and id_motivo = co.id_motivo and id_op = co.id_op
                ) b
            where
                a.id_operacion = b.id_operacion(+)
                and a.num_pago = b.num_pago(+)
                and a.id_operacion = co.id_operacion;

            usp_print('
                    <tr valign="top">
                        <td rowspan="'||(ln_cont_pagos + 1)||'" >
                            <table>
                                <tr style="width:100%">
                                    <td colspan="2" align="left"><b>'||co.des_motivo||'</b> ( '||co.f_operacion||' )</td>
                                </tr>
                                <tr>
                                    <td align="left">Programado: </td>
                                    <td align="left">'||lv_total_progr_op||'</td>
                                </tr>
                                <tr>
                                    <td align="left">A Pagar: </td>
                                    <td align="left">'||lv_total_pagar_op||'</td>
                                </tr>
                            </table>
                        </td>
                    </tr>');
 --usp_print('<br>ag_reg_cal_modif:'||ag_reg_cal_modif);
            -------- Calendario por Operacion ---------
            for cc in c_cal(co.id_operacion,co.id_op,co.id_motivo,lv_id_usuario) loop
            begin ---------- mostrar datos del calendario -----
                if ag_reg_cal_modif is null then --- Muestra 'Modificar'
                    usp_print('
                    <tr>
                        <td align="center">'||cc.num_pago||'</td>
                        <td align="center">'||cc.fec_prog||'</td>
                        <td align="right">'||to_char(cc.monto_prog, '999,999,999,999.00')||'</td>');
                    if cc.ind_eliminar = 1 then
                        usp_print('
                        <td colspan="3">&nbsp;</td>');
                    else
                        usp_print('
                        <td align="center">'||cc.fec_pago||'</td>
                        <td align="right">'||to_char(cc.monto_pago, '999,999,999,999.00')||'</td>');
                        if ln_contr_trans = 0 then
                            usp_print('
                        <td align="center">
                            <img src="img/editar.gif" alt="Modificar Datos" style="cursor:hand" onclick="EditRow(this,'||co.id_motivo||co.id_op||cc.num_pago||')"/>&#xa0;&#xa0;
                            <img src="'||gpk_eliminar||'" alt="Eliminar" onclick="DeleteRow(this,'''||lv_id_usuario||''','||co.id_motivo||','||co.id_operacion||','||co.id_op||','||cc.num_pago||');"/>&#xa0;&#xa0;
                        </td>');
                        else
                            usp_print('
                        <td align="center">&nbsp;</td>');
                        end if;
                    end if;
                    usp_print('
                    </tr> ');
                else ------ Muestra 'Aceptar' o Vacio
                    if ( ag_reg_cal_modif = trim(co.id_motivo||co.id_op||cc.num_pago) ) then
                        ------------ Fila que esta editandose -----
                        usp_print('
                    <tr>
                        <td align="center">'||cc.num_pago||'</td>
                        <td align="center">'||cc.fec_prog||'</td>
                        <td align="right">'||to_char(cc.monto_prog,'999,999,999,999.00')||'</td>');
                        if cc.ind_eliminar = 1 then
                            usp_print('
                        <td colspan="3">&nbsp;</td>');
                        else
                            usp_print('
                        <td align="left" width="18%">

                        <div class="input-group datepicker" id="idDivTxtFechaIni">
                <div class="input-group-addon  add-on">
                     <span class="glyphicon glyphicon-calendar"></span>
                </div>
               <input type="text" name="fec_pago_mod" value="'||cc.fec_pago||'" style="width:98%" data-format="dd/MM/yyyy" class="form-control"/>
          </div>
                        </td>
                        <td align="left">
                            <input name="monto_pago_mod" style="width:98%" align="right" value="'||cc.monto_pago||'"/>
                        </td>
                        <td align="center">
                            <img src="'||gpk_aceptar||'" alt="Aceptar" onclick="UpdateRow(this,'''||lv_id_usuario||''','||co.id_motivo||','||co.id_operacion||','||co.id_op||','||cc.num_pago||');"/>&#xa0;&#xa0;
                            <img src="'||gpk_eliminar||'" alt="Cancelar" style="cursor:hand" onclick="ag_reg_cal_modif.value='''';Refresh(this);"/>
                        </td>');
                        end if;
                        usp_print('
                    </tr>');
                    else ------------ Fila que No se edita -----
                        usp_print('
                    <tr>
                        <td align="center">'||cc.num_pago||'</td>
                        <td align="center">'||cc.fec_prog||'</td>
                        <td align="right">'||to_char(cc.monto_prog, '999,999,999,999.00')||'</td>');
                        if cc.ind_eliminar = 1 then
                            usp_print('
                        <td colspan="3">&nbsp;</td>');
                        else
                            usp_print('
                        <td align="center">'||cc.fec_pago||'</td>
                        <td align="right">'||to_char(cc.monto_pago, '999,999,999,999.00')||'</td>
                        <td align="center">&nbsp;</td>');
                        end if;
                        usp_print('
                    </tr>');
                    end if;
                end if;
            end;
            end loop;
            ln_fila:= ln_fila + 1;
        end;
        end loop;
        usp_print('
                </table>
            </td>
        </tr>');
    end;
    end if;

  ----------- Items para Resolucion Parcial ------------
    IF( ag_cod_tipo_resoucion is not null and ag_cod_tipo_resoucion = '2') THEN
        usp_print('

        <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>');
            usp_print( PKU_PROCESOS_COMUN.f_get_subTitulo('Items del Contrato'));
            usp_print('
            <th class="th1">Anular Items</th>
            <th class="th1">Item Nro.</th>
            <th class="th1">Descripci&oacute;n</th>
            <th class="th1">Monto</th>  
            <th class="th1">Fecha de Registro</th>');
            ln_fila:= 1;
            -------- Items del Contrato --------
            For ci in c_item_cont(ln_cod_contrato) Loop
                usp_print('
            <tr id="tr_'||ln_fila||'">
                <td align="center" width= "9%">
                    <input type="hidden"   name="row"            value="'||ln_fila||'"/>
                    <input type="hidden"   name="item"           value="'||ci.proc_item||'" />
                    <input type="checkbox" name="proc_item"      value="'||ci.proc_item||'" border="0"/>
                </td>
                <td align="center" width= "8%" >'||ci.proc_item||'</td>
                <td align="left"   width= "61%">'||ci.descripcion||'</td>
                <td align="center" width= "7%">'||ci.monto||'</td>
                <td align="center" width= "15%">'||to_char(ci.f_registro, 'dd/mm/yyyy HH:mi')||'</td>
            </tr>');
                ln_fila:= ln_fila + 1;
            End loop;
            usp_print('
        </table>');

    End If;


    usp_print('
    </table>
    <input type="hidden" name="cant_items" value="'||(ln_fila-1)||'"/>
    <br/>');

    --------------- Java Script ----------------
    usp_print('
    <script language="javascript">
    function Refresh(obj)
    {
        thisform.scriptdo.value = "doNewNulidad1";
        thisform.submit();
        return true;
    }

    function TipoOperacion(obj)
    {
        var opcion = eval(thisform.ls_cod_tipo_operacion.value);
        if( opcion == "0" )
        {
            thisform.scriptdo.value="doNewNulidad";
            thisform.submit();
            return true;
        }
        else
            return false;
    }

    function EditRow(obj,valor)
    {
        thisform.ag_reg_cal_modif.value=valor;
        thisform.scriptdo.value="doNewNulidad1";
        thisform.submit();
        return true;
    }

    function UpdateRow(obj,idusuario,idmotivo,idoper,idop,numpago)
    {
        if ( !ValidarBlanco(thisform.fec_pago_mod,"Fecha de Pago"))     return false;
        if ( !ValidarFecha(thisform.fec_pago_mod,"Fecha de Pago"))      return false;
        if ( !ValidarBlanco(thisform.monto_pago_mod,"Monto de Pago"))   return false;
        if ( !ValidarDecimal(thisform.monto_pago_mod,"Monto de Pago"))  return false;

        thisform.ag_reg_cal_modif.value                     = "";
        thisform.ag_id_usuario.value                        = idusuario;
        thisform.ag_id_motivo.value                         = idmotivo;
        thisform.ag_id_operacion.value                      = idoper;
        thisform.ag_id_op.value                             = idop;
        thisform.ag_num_pago.value                          = numpago;
        thisform.ag_fec_pago.value                          = thisform.fec_pago_mod.value;
        thisform.ag_monto_pago.value                        = thisform.monto_pago_mod.value;
        thisform.scriptdo.value                             = "doUpdateCalNulDet";

        thisform.submit();
        return true;
    }

    function DeleteRow(obj,idusuario,idmotivo,idoper,idop,numpago)
    {
        thisform.ag_reg_cal_modif.value = "";
        thisform.ag_id_usuario.value    = idusuario;
        thisform.ag_id_motivo.value     = idmotivo;
        thisform.ag_id_operacion.value  = idoper;
        thisform.ag_id_op.value         = idop;
        thisform.ag_num_pago.value      = numpago;
        thisform.scriptdo.value         = "doDeleteCalNulDet";
        thisform.submit();
        return true;
    }

  function ValidarItems(obj){
        var a=0;
        if( thisform.ag_cod_tipo_resoucion.value == 2 )
        {
            for( var i=0; i<thisform.cant_items.value; i++ )
            {
                if ( !thisform.proc_item.type )
                {
                    if( thisform.proc_item[i].checked == true )
                        a++;
                }
                else
                {
                    if( thisform.proc_item.checked == true )
                        a++;
                }
            }
            if( a == 0 )
            {
                alert("Seleccione al menos un Item del Contrato");
                return false;
            }
            else
                return true;
            return true;
        }
        else
            return true;
    }


    function grabar(obj,scrobj)
    {
        var caditems = "";
        var f_resolucion = thisform.ag_fec_resolucion;
        if( thisform.ag_fec_resolucion.value == "" )
        {
            alert("Debe Ingresar la fecha de la Nulidad");
            return false;
        }
        if( thisform.ag_cod_causa_resolucion.value == "" )
        {
            alert("Debe Ingresar la Causal de la Nulidad");
            return false;
        }

        // Obtener los items seleccionados, pe: "1,2,3"
            if( thisform.ag_cod_tipo_resoucion.value == "2" )
            {
                for( var i=0; i<thisform.cant_items.value; i++ )
                {
                    if ( !thisform.proc_item.type )
                    {
                        if( thisform.proc_item[i].checked == true )
                        {
                            caditems = caditems + thisform.item[i].value + ",";
                        }
                    }
                    else
                    {
                        if( thisform.proc_item.checked == true )
                            caditems=thisform.item.value;
                    }
                }
            }
            if ( !ValidarItems(obj) )
                return false;

            if(thisform.pfiletoupload1.value != null && thisform.pfiletoupload1.value != ""){
               extencion1 = thisform.pfiletoupload1.value
               extencion1 = extencion1.substring((extencion1.length)-4,extencion1.length)

               if (extencion1 != ".doc" && extencion1 != ".zip" && extencion1 != ".pdf")
                 {
                  alert("El archivo de extensi\xf3n "+extencion1+" no est\xe1 permitido.");
                  thisform.pfiletoupload1.focus();    
                  return false;
                 }
               var namearchive = "'||to_char(sysdate, 'ddmmyyyyHH24MISS')||'"+extencion1;
               thisform.pfiletoupload_file1.value = namearchive;
               }else{
                  alert("Debe de adjuntar el documento");                                
                  return false;
               }

        thisform.scriptdo.value = scrobj;
        thisform.ag_cadena_items.value = caditems;
        thisform.submit();
    }

    function cancelar(obj,scrobj)
    {
        thisform.scriptdo.value=scrobj;
        thisform.submit();
    }
    </script>');
End;



PROCEDURE uspTmpContCalDoUpdate(
      session__userid         varchar2,
      ag_id_motivo            varchar2,
      ag_id_operacion         varchar2,
      ag_id_op                varchar2,
      ag_num_pago             varchar2,
      ag_fec_pago             varchar2,
      ag_monto_pago           varchar2,
      ag_cod_contrato         varchar2,
      ag_eue_codigo           varchar2,
      ag_cod_tipo_resoucion   varchar2,
      ag_fec_resolucion       varchar2,
      ag_cod_causa_resolucion varchar2,
      ag_reg_cal_modif        varchar2,
      ls_cod_tipo_operacion   varchar2
)
IS

    ln_existe_reg  number;

BEGIN

    reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_3.js_script('var _error = 0;');
    Select count(1) into ln_existe_reg from reg_procesos.tmp_contrato_operacion_cal a  where a.id_usuario = trim(session__userid) and a.id_motivo = to_number(ag_id_motivo) and a.id_operacion = to_number(ag_id_operacion) and a.num_pago = to_number(ag_num_pago) and a.id_op = to_number(ag_id_op);

    IF ln_existe_reg > 0 THEN
          UPDATE reg_procesos.tmp_contrato_operacion_cal
             SET fec_pago = ag_fec_pago, monto_pago = to_number(ag_monto_pago), d_fec_registro = sysdate
           WHERE id_usuario = trim(session__userid) and id_motivo = to_number(ag_id_motivo)and id_operacion = to_number(ag_id_operacion) and num_pago = to_number(ag_num_pago) and id_op = to_number(ag_id_op);
    ELSE

      BEGIN
          INSERT INTO reg_procesos.tmp_contrato_operacion_cal(id_usuario,id_motivo,id_operacion,id_op, num_pago,fec_pago,monto_pago, d_fec_registro)
          VALUES (trim(session__userid),to_number(ag_id_motivo), to_number(ag_id_operacion), to_number(ag_id_op), to_number(ag_num_pago),ag_fec_pago,ag_monto_pago, sysdate);
      EXCEPTION
          WHEN OTHERS THEN
           reg_procesos.pku_ss_mod_contratos.f_msg_error('Error al intentar Actualizar el Calendario de Pagos','''doViewNulidad''');
      END;

    END IF;

    COMMIT;

    usp_print('

    <input type="hidden" name ="ag_cod_contrato"            value="'||ag_cod_contrato||'"/>
    <input type="hidden" name ="ag_eue_codigo"              value="'||ag_eue_codigo||'"/>
    <input type="hidden" name ="ag_cod_tipo_resoucion"      value="'||ag_cod_tipo_resoucion||'"/>
    <input type="hidden" name ="ag_fec_resolucion"          value="'||ag_fec_resolucion||'"/>
    <input type="hidden" name ="ag_cod_causa_resolucion"    value="'||ag_cod_causa_resolucion||'"/>
    <input type="hidden" name ="ag_reg_cal_modif"           value="'||ag_reg_cal_modif||'"/>
    <input type="hidden" name ="ls_cod_tipo_operacion"      value="'||ls_cod_tipo_operacion||'"/>    


    <script language="javascript">
        thisform.scriptdo.value = "doNewNulidad";
        if (_error == 0 ){
                thisform.submit();
        }
    </script>');

END;



PROCEDURE uspResolucionDoInsert(
    session__N_CONVOCA             varchar2,
    session__COD_CONTRATO          varchar2,
    ag_cod_moneda                  varchar2,
    ag_cod_tipo_resoucion          varchar2,
    ag_cod_causa_resolucion        varchar2,
    ag_fec_resolucion              varchar2,
    ag_ind_siaf                    varchar2,
    ag_cadena_items                varchar2,
    ag_operacion                   number,
    session__userid                varchar2,
    ag_doc_resolucion              varchar2,
    pfiletoupload1                 varchar2,
    pfiletoupload_file1            varchar2,
    --ag_file__size                  varchar2,
    --ag_file__mimetype              varchar2,
    WriteFileDirectoryDynamic      varchar2,
    iisenv__remote_host            varchar2,
    session__FileSingedHTTP        varchar2
)
Is

    -------- Pagos del Calendario ----
    CURSOR c_modif_cal(p_id_operacion in number, p_id_motivo in number) is
    SELECT to_date(x.fec_pago,REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_fecha) fec_pago_tmp, 
           cal.fec_pago fec_pago_cal, 
           cal.codmoneda,
           x.id_motivo,x.id_op,  
           cal.num_pago,
           x.monto_pago monto_pago_tmp,
           cal.monto_pago monto_pago_cal
      FROM reg_procesos.contrato_operacion_calendario cal 
      LEFT OUTER JOIN reg_procesos.tmp_contrato_operacion_cal x
        ON x.id_operacion = cal.id_operacion and x.num_pago = cal.num_pago and x.id_usuario = session__userid and x.ind_eliminar is null and x.id_motivo = 1
     WHERE cal.id_operacion =     p_id_operacion 
     ORDER BY 1;

    CURSOR c_modif_cal_NUL(p_id_operacion in number, p_id_motivo in number) is
    SELECT to_date(x.fec_pago,REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_fecha) fec_pago_tmp, 
           cal.fec_pago fec_pago_cal, 
           cal.codmoneda,
           x.id_motivo,x.id_op,  
           cal.num_pago,
           x.monto_pago monto_pago_tmp,
           cal.monto_pago monto_pago_cal,
           x.ind_eliminar 
      FROM reg_procesos.contrato_operacion_calendario cal 
      LEFT OUTER JOIN reg_procesos.tmp_contrato_operacion_cal x
        ON x.id_operacion = cal.id_operacion and x.num_pago = cal.num_pago and x.id_usuario = session__userid /*and x.ind_eliminar is null*/ and x.id_motivo = 1
     WHERE cal.id_operacion =     p_id_operacion 
     ORDER BY 1;



    ln_cod_contrato         number;
    ln_cod_resolucion       number;
    ln_cod_tipo_resoucion   number;
    ln_cod_causa_resolucion number;
    ln_ind_siaf             number;
    lini                    number;
    lfin                    number;
    lv_item                 varchar2(10);
    lv_cadena_items         varchar2(2000);
    ln_id_operacion         number;
    lvtipodocumento         varchar2(10);
    lv_codtipofile          varchar2(10);  
    lv_ruta                 varchar2(350);  
    ln_cod_tipo_doc         number;
    ln_total_pago           NUMBER;

Begin

    ln_cod_contrato         := to_number(session__COD_CONTRATO);
    ln_cod_tipo_resoucion   := to_number(ag_cod_tipo_resoucion);
    ln_cod_causa_resolucion := to_number(ag_cod_causa_resolucion);
    ln_ind_siaf             := to_number(ag_ind_siaf);

   ---------- Obtener Codigo de Resolucion ----------

   select REG_PROCESOS.s_contrato_resolucion.NEXTVAL into ln_cod_resolucion from dual;

   lvtipodocumento := upper(substr(pfiletoupload_file1,length(pfiletoupload_file1)-2,length(pfiletoupload_file1)));

   lv_ruta := WriteFileDirectoryDynamic||'/'||pfiletoupload_file1;

   select cod_tipo_file into lv_codtipofile from Reg_procesos.tipo_archivo where  ext_tipo_file = lvtipodocumento;

   IF ag_operacion = 1 THEN
        ln_cod_tipo_doc := 610;

        ---------- Ingresar la Resolucion ----------
        BEGIN        
          INSERT INTO REG_PROCESOS.contrato_resolucion (
            n_cod_resolucion, n_cod_contrato, cod_tipo_resolucion,cod_causa_resoucion, fec_resolucion, estado_contrato,usu_creacion,ip_creacion )
          VALUES (
            ln_cod_resolucion, ln_cod_contrato, ln_cod_tipo_resoucion,ln_cod_causa_resolucion,to_date(ag_fec_resolucion,REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_fecha), 1,session__userid,iisenv__remote_host );

          EXCEPTION
                  WHEN OTHERS THEN
                  reg_procesos.pku_ss_mod_contratos.f_msg_error('Error al intentar registrar los datos de la Resoluci&oacute;n','''doNewNulidad''');

        END;

    ELSE

        ln_cod_tipo_doc := 620;

        ----------- Ingresar Anulacion --------------
        BEGIN
          INSERT INTO REG_PROCESOS.contrato_resolucion (
            n_cod_resolucion, n_cod_contrato, cod_tipo_resolucion,cod_causa_resoucion, fec_resolucion, estado_contrato,usu_creacion,ip_creacion )        
          VALUES (
            ln_cod_resolucion, ln_cod_contrato, 1, ln_cod_causa_resolucion,to_date(ag_fec_resolucion,REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_fecha),2 ,session__userid,iisenv__remote_host);

        EXCEPTION
                  WHEN OTHERS THEN
                  reg_procesos.pku_ss_mod_contratos.f_msg_error('Error al intentar registrar los datos de la Nulidad','''doNewNulidad''');
        END;

    END IF;



   ------------ Ingresar el documento  ------------------------------
    BEGIN 
       INSERT INTO REG_PROCESOS.convocatoria_doc (
             cod_tipo_doc, doc_url, cod_tipo_file, doc_nombre, user_upload, ip_from_upload, nro_doc, FEC_UPLOAD, /*tamano_bytes,*/ n_cod_contrato, N_CONVOCA )
       VALUES(
             ln_cod_tipo_doc, lv_ruta, lv_codtipofile, pfiletoupload_file1, session__userid, iisenv__remote_host, ag_doc_resolucion, sysdate,  /*ag_file__size,*/ln_cod_contrato, session__N_CONVOCA );

        UPDATE REG_PROCESOS.contrato_resolucion 
           SET cod_doc = pk_convocatoria.gn_cod_documento 
         WHERE n_cod_resolucion = ln_cod_resolucion;    

       EXCEPTION
             WHEN OTHERS THEN
             reg_procesos.pku_ss_mod_contratos.f_msg_error('Error al intentar registrar el Archivo','''doNewNulidad''');

    END;


    ------- Actualizar Campos del Contrato: Transferencia al MEF -------
    IF ln_ind_siaf = 1 THEN

      SELECT id_operacion INTO ln_id_operacion FROM reg_procesos.CONTRATO WHERE n_cod_contrato = ln_cod_contrato;

        -- Para el contrato
        select sum(nvl(a,b)) into ln_total_pago  
          FROM (
        Select x.id_motivo,x.id_op,  cal.num_pago ,x.monto_pago a,cal.monto_pago b
          From reg_procesos.contrato_operacion_calendario cal 
          left outer join reg_procesos.tmp_contrato_operacion_cal x
            on x.id_operacion = cal.id_operacion and x.num_pago = cal.num_pago and x.id_usuario = session__userid  and x.id_motivo = 1  and x.ind_eliminar is null
         Where cal.id_operacion = ln_id_operacion 
         );


      UPDATE reg_procesos.CONTRATO SET m_contratado = ln_total_pago,id_operacion_src = ln_id_operacion WHERE n_cod_contrato = ln_cod_contrato;

      INSERT INTO contrato_operacion (cod_operacion_contrato, n_cod_contrato, IND_MODIFICACION, cod_reduccion,USU_CREACION,ip_creacion) VALUES (1,ln_cod_contrato,2,ln_cod_resolucion,session__userid,iisenv__remote_host);

      UPDATE reg_procesos.CONTRATO SET  id_operacion = PK_CONVOCATORIA.gn_id_operacion WHERE n_cod_contrato = ln_cod_contrato;

   IF ag_operacion = 1 THEN 
      FOR cmc in c_modif_cal(ln_id_operacion,1) LOOP
          BEGIN 
              INSERT INTO reg_procesos.CONTRATO_OPERACION_CALENDARIO (num_pago, fec_pago, codmoneda, monto_pago ) 
              VALUES (cmc.num_pago,nvl(cmc.fec_pago_tmp,cmc.fec_pago_cal), cmc.codmoneda, nvl(cmc.monto_pago_tmp,cmc.monto_pago_cal) );

              EXCEPTION
                 WHEN OTHERS THEN
                      reg_procesos.pku_ss_mod_contratos.f_msg_error('Error al intentar registrar el Calendario','''doNewNulidad''');
          END;     
       END LOOP; 
   ELSE
       FOR cmc in c_modif_cal_NUL(ln_id_operacion,1) LOOP

         IF CMC.IND_ELIMINAR <> 1 THEN 
             BEGIN
              INSERT INTO reg_procesos.CONTRATO_OPERACION_CALENDARIO (num_pago, fec_pago, codmoneda, monto_pago ) 
              VALUES (cmc.num_pago,nvl(cmc.fec_pago_tmp,cmc.fec_pago_cal), cmc.codmoneda, nvl(cmc.monto_pago_tmp,cmc.monto_pago_cal) );

              EXCEPTION
                 WHEN OTHERS THEN
                      reg_procesos.pku_ss_mod_contratos.f_msg_error('Error al intentar registrar el Calendario','''doNewNulidad''');
              END;  
          END IF;   
        END LOOP; 
   END IF;



   END IF;


    --- Resolucion Total ---
    IF ln_cod_tipo_resoucion = 1 THEN

        update REG_PROCESOS.item_contrato  set n_cod_resolucion = ln_cod_resolucion  where n_cod_contrato = ln_cod_contrato;

    ELSE  
    --- Resolucion Parcial ---

        IF ag_cadena_items IS NOT NULL THEN

            lv_cadena_items := TRIM(ag_cadena_items);
            lini            := 1;

            WHILE ( length( lv_cadena_items ) > 0 ) LOOP

                lfin := instr(lv_cadena_items,',');

                IF lfin = 0 THEN
                    lfin := length(lv_cadena_items) + 1;
                END IF;

                lv_item := substr(lv_cadena_items,lini,(lfin - lini));
                lv_cadena_items := substr(lv_cadena_items,lfin + 1,length(lv_cadena_items));

                update REG_PROCESOS.item_contrato set n_cod_resolucion = ln_cod_resolucion where n_cod_contrato = ln_cod_contrato and proc_item = to_number(lv_item);

            END LOOP;

        END IF;

    END IF;


    --------- Borrar tabla temporal ---------
    Delete from reg_procesos.tmp_contrato_operacion_cal where id_usuario = session__userid;

    commit;

    usp_print('

    <input type="hidden" name="ag_cod_tipo_resoucion"   value="'||ag_cod_tipo_resoucion||'"/>
    <input type="hidden" name="ag_fec_resolucion"       value="'||ag_fec_resolucion||'"/>
    <input type="hidden" name="ag_cod_causa_resolucion" value="'||ag_cod_causa_resolucion||'"/>


    <script>
        thisform.scriptdo.value = "doViewNulidad";
        thisform.submit();
    </script>');

End;



PROCEDURE uspNewResolucionDoEdit(
    ag_cod_tipo_resoucion       varchar2,
    ag_fec_resolucion           varchar2,
    ag_cod_causa_resolucion     varchar2,
    ag_reg_cal_modif            varchar2,
    ag_cm_opc                   varchar2,
    session__N_CONVOCA          varchar2,
    session__COD_CONTRATO       varchar2,
    session__userid             varchar2,    
    ag_doc_resolucion           varchar2,
    ls_cod_tipo_operacion       varchar2)
IS

    --------- Operaciones --------------
    Cursor c_oper(p_n_cod_contrato in number) is
    Select
        1 id_motivo, 'Contrato' des_motivo, c.n_cod_contrato id_op,
        to_char(c.f_contrato,'dd/mm/yyyy') f_operacion, id_operacion
    from reg_procesos.contrato c
    where c.n_cod_contrato = p_n_cod_contrato
    /*union
    Select
        4 id_motivo, 'Contrato Complementario' des_motivo, c.n_cod_contrato id_op,
        to_char(c.f_contrato,'dd/mm/yyyy') f_operacion, id_operacion
    from reg_procesos.contrato c
    where c.n_cod_contrato_de_renovac = p_n_cod_contrato
    and cod_operacion_contrato = 6
    order by 1*/;

    ------- Calendario de cada operacion -------
    Cursor c_cal( p_id_operacion in number, p_id_op in number, p_id_motivo in number, p_id_usuario in varchar2) is
    Select
        a.num_pago, a.codmoneda, to_char(a.fec_pago,'dd/mm/yyyy') fec_prog,
        a.monto_pago monto_prog, nvl(b.fec_pago, to_char(a.fec_pago,'dd/mm/yyyy')) fec_pago,
        nvl(b.monto_pago,a.monto_pago) monto_pago, b.ind_eliminar
    from
        reg_procesos.contrato_operacion_calendario a,
        (   Select
                x.id_operacion, x.num_pago, x.fec_pago, x.monto_pago, x.ind_eliminar
            from reg_procesos.tmp_contrato_operacion_cal x
            where
                id_usuario = p_id_usuario
                and id_motivo  = p_id_motivo
                and id_op      = p_id_op
                and x.ind_eliminar is null
        ) b
    where
        a.id_operacion = b.id_operacion(+)
        and a.num_pago = b.num_pago(+)
        and a.id_operacion = p_id_operacion;

    ------------ Items del Contrato ----------------
    Cursor c_item_cont(p_n_cod_contrato in number) is
        select c.n_cod_contrato,
        ic.descripcion, i.n_convoca,
        i.proc_item,
         to_char(i.monto,REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_dinero) monto,
        i.f_registro, i.f_ult_mod, i.n_cod_resolucion, i.cantidad, i.unm_codigo
        from contrato c
        inner join reg_procesos.item_contrato i
        on c.n_cod_contrato = i.n_cod_contrato
        inner join reg_procesos.item_convoca ic
        on i.n_convoca = ic.n_convoca
        and i.proc_item = ic.proc_item
        where 
        (c.n_cod_contrato = p_n_cod_contrato 
         /*or (c.n_cod_contrato_de_renovac = p_n_cod_contrato and c.cod_operacion_contrato = 6)*/
        );

    ------- Variables ------
    lv_eue_codigo            varchar2(6);
    lv_anhoentidad           varchar2(4);
    ln_n_convoca             number;
    lv_proc_sigla            varchar2(60);
    lv_proc_tipo_sigla       varchar2(20);
    lv_proc_num              varchar2(16);
    ln_proc_tipo             number;
    ln_n_proceso             number;
    ln_cod_contrato          number;
    lv_n_contrato            REG_PROCESOS.contrato.n_contrato%type;
    ln_ind_uso_siaf          number;
    ln_cont_pagos            number;
    ln_fila                  number;
    lv_total_pago_cont_src   varchar2(20);
    lv_total_progr_op        varchar2(20);
    lv_total_pagar_op        varchar2(20);
    ln_contr_trans           number;
    ln_cadena                varchar(5000);
    lv_ruta_file             varchar2(250);    
    ln_id_operacion          NUMBER;

    lv_combo_tipoAlcance     varchar2(4000);
    lv_combo_tipoResolucion  varchar2(4000);
    lv_combo_tipoResolucion2 varchar2(4000);  

    ctipoAlcance            ref_cursor;
    ctipoResolucion         ref_cursor;
    ctipoResolucion2        ref_cursor;


Begin


    ctipoAlcance             :=  PKU_SS_UTILES.f_ctipo_causa(1);
    ctipoResolucion          :=  PKU_SS_UTILES.f_ctipo_resolucion(null);
    ctipoResolucion2         :=  PKU_SS_UTILES.f_ctipo_resolucion(2);

    -- Inicializamos los combos
    lv_combo_tipoAlcance     := PKU_SS_UTILES.f_retorna_combo(ctipoAlcance, 'ag_cod_causa_resolucion', ag_cod_causa_resolucion,'Seleccione causal ...','style="width:99%"');
    lv_combo_tipoResolucion  := PKU_SS_UTILES.f_retorna_combo(ctipoResolucion, 'ag_cod_tipo_resoucion', ag_cod_tipo_resoucion,'Seleccione alcance ...','onchange="Refresh(this);" style="width:99%"');
    lv_combo_tipoResolucion2 := PKU_SS_UTILES.f_retorna_combo(ctipoResolucion2, 'ag_cod_tipo_resoucion', ag_cod_tipo_resoucion,'Seleccione alcance ...','onchange="Refresh(this);" style="width:99%"');

    ln_cod_contrato          := to_number(session__COD_CONTRATO);
    ln_n_convoca             := to_number(session__N_CONVOCA);

    ------ Verificar si tiene transferencias el contrato ------
    -- ln_contr_trans:= f_contrato_transferido(ln_cod_contrato);
    -- Por incidencia 127 se elimina la validacion de contrato transferido
    ln_contr_trans:= 0;

    -------- Funciones Script -------
    PKU_PROCESOS_COMUN.dojscript;
    PKU_PROCESOS_COMUN.dojscriptfechas;
    PKU_GESTOR_CONT_FUNCIONES_JS_3.sp_javascript_nulidad;

    ----- Obtener Datos de la Convocatoria-------
    IF ln_n_convoca IS NOT NULL THEN
        BEGIN
          SELECT c.codconsucode, c.n_proceso, c.anhoentidad, c.proc_tipo, c.proc_num, c.proc_sigla, t.proc_tipo_sigla
            INTO lv_eue_codigo, ln_n_proceso, lv_anhoentidad, ln_proc_tipo,lv_proc_num, lv_proc_sigla, lv_proc_tipo_sigla
            FROM REG_PROCESOS.convocatorias c,
                 REG_PROCESOS.tipo_procesos t
           WHERE t.proc_tipo = c.proc_tipo AND c.n_convoca = ln_n_convoca;
        EXCEPTION
            WHEN OTHERS THEN
                pku_ss_mod_contratos.f_msg_error('Error al intentar halalar los datos de la convocatoria','''doViewNulidad''');
                return;
        END;
     END IF;

    ----- Datos para subir el archivo

    lv_ruta_file  := gpk_directorio_resolucion ||'\'||lv_anhoentidad||'\'||lv_eue_codigo||'\'||ln_n_convoca;

    ----- Obtener Datos del Contrato ----
    BEGIN
        Select c.n_contrato,C.Id_Operacion into lv_n_contrato, ln_id_operacion  from REG_PROCESOS.contrato c where c.n_cod_contrato = ln_cod_contrato;
    EXCEPTION
        WHEN OTHERS THEN
         reg_procesos.pku_ss_mod_contratos.f_msg_error('Error al intentar registrar obtener los datos del Contrato','''doViewNulidad''');
          return;
    END;

     usp_print('
    <input type="hidden" name="ag_reg_cal_modif"        value=""/>
    <input type="hidden" name="ag_id_motivo"/>
    <input type="hidden" name="ag_id_operacion"/>
    <input type="hidden" name="ag_operacion"            value="1"/>
    <input type="hidden" name="ag_id_op"/>
    <input type="hidden" name="ag_num_pago"/>
    <input type="hidden" name="ag_fec_pago"/>
    <input type="hidden" name="ag_monto_pago"/>
    <input type="hidden" name="ag_cadena_items"/>
    <input type="hidden" name="ag_cm_opc"               value="'||ag_cm_opc||'"/>
    <input type="hidden" name="WriteFileDirectory"      value="FileSinged">
    <input type="hidden" name="WriteFileDirectoryDynamic" value="'||lv_ruta_file||'" />   
    <input type="hidden" name="av_envento"    id="av_envento"  value="doNewNulidad"    />

    <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
    <tr>');

    usp_print(
            PKU_SS_UTILES.f_get_titulo_contrato ( ln_cod_contrato, 'Nulidad / Resoluci&oacute;n del Contrato u Orden de Compra o Servicios' ,'Nulidad / Resoluci&oacute;n del Contrato u Orden de Compra o Servicios '));

    usp_print('
            <td align="right" valign=top width="50%">');
    if ln_contr_trans = 0 then
        usp_print('
                <input type="button" value="Grabar" OnClick="grabar(this,''doInsertNulidad'')"/>
   ');
    end if;

    usp_print('
                <input type="button" value="Cancelar" OnClick="cancelar(this,''doCancelarRegistro'')"/>
            </td>
        </tr>
    </table>
    <br>');

    ------- Mostrar Mensaje si tiene transferencias -----
    IF ln_contr_trans = 1 THEN
        usp_print(
            pku_procesos_comun.f_putMensaje(
                'El Contrato ya tiene transferencias al MEF, NO puede ser resuelto.',
                '')
        );
    END IF;

    usp_print('
    <table width=100% class="table table-striped">');
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('N&uacute;mero del Contrato (u Orden de Compra o Servicio)',
                '<input type="text" name="n_contrato" readonly style="width:98%" value="'||lv_n_contrato||'"/>',
                '.'));
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Operación',
                '<SELECT name="ls_cod_tipo_operacion" onchange="TipoOperacion(this);" style="width:99%" >
                    <option value = "">-Seleccionar-</option>
                    <option value = "0">Resolución de Contrato</option>
                    <option value = "1">Nulidad de Contrato</option>
                </SELECT>',
                '.'));


    IF ls_cod_tipo_operacion  is NULL THEN 
       usp_print('</table>');
       return;
    ELSE
       PKU_GESTOR_CONT_FUNCIONES_JS_3.js_script('thisform.ls_cod_tipo_operacion.value = '||ls_cod_tipo_operacion||';');
    END IF;

    -------------- Obtener el indicador del SIAF ----------------
    BEGIN
        select ep.ind_uso_siaf into ln_ind_uso_siaf
          from reg_procesos.entidadue_anho_tipo_proceso ep, reg_procesos.convocatorias c, reg_procesos.contrato cnt
         where ep.eue_codigo  = c.codconsucode and ep.eue_anho = c.anhoentidad  and c.n_convoca = cnt.n_convoca and cnt.n_cod_contrato = ln_cod_contrato and c.proc_tipo = ep.tip_codigo;
   EXCEPTION
        WHEN OTHERS THEN
         reg_procesos.pku_ss_mod_contratos.f_msg_error('Error al intentar obtener informacion de Transferencia al SIAF','''doViewNulidad''');
         return;
   END;

    -- Genera el combo, validando si ya se registro una  resolucion total del contrato
    IF not PKU_SS_UTILES.f_valida_resolucionTotal(ln_cod_contrato) THEN
        ln_cadena := lv_combo_tipoResolucion;
        ELSE
        ln_cadena := lv_combo_tipoResolucion2;
    END IF;

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Documento de Resoluci&oacute;n del Contrato',
                '<input class="form-control" name="ag_doc_resolucion" value="'||ag_doc_resolucion||'">',
                '.'));

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Fecha del Documento de Resoluci&oacute;n',
                '<div class="input-group datepicker" id="idDivTxtFechaIni">
                <div class="input-group-addon  add-on">
                     <span class="glyphicon glyphicon-calendar"></span>
                </div>
               <input type="text" name="ag_fec_resolucion" value="'||ag_fec_resolucion||'" style="width:98%" data-format="dd/MM/yyyy" class="form-control"/>
          </div>','.'));

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Alcance de la Resoluci&oacute;n',
                '<input type="hidden" name="ag_ind_siaf" value="'||ln_ind_uso_siaf||'"/>'
                ||ln_cadena,
                '.'));

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Causal de la Resoluci&oacute;n',
                lv_combo_tipoAlcance,
                '.'));

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Adjuntar Archivo',
                '<input type="file"  name="pfiletoupload1" style="width:100%"  value="">
                <input type="hidden" name="pfiletoupload_file1" value="" />',
                '.'));


    ---------- Calendario del Contrato ----------
    IF ln_ind_uso_siaf = 1 THEN

        ------- Total Pagos Origen --------
        Select sum(a.monto_pago) into  lv_total_pago_cont_src
          from reg_procesos.contrato_operacion_calendario a
        where a.id_operacion in (
               Select id_operacion From reg_procesos.contrato c where c.n_cod_contrato = ln_cod_contrato
                      );


        usp_print('
        <tr>
            <td class="c1">(*)Calendario<br/>( Indique como queda el calendario despues de esta resolución conserve los montos pagados y los que se pagarán ) </td>
            <td class="c2" colspan="2">
                <table id="cal_idtable" border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
                    <th class="th1">Operaci&oacute;n</th>
                    <th class="th1">Nro</th>
                    <th class="th1">Fecha Prog.</th>
                    <th class="th1">Monto Prog</th>
                    <th class="th1">Fecha Pago</th>
                    <th class="th1">Monto Pago</th>');


        IF ln_contr_trans = 0 then -- Contrato sin transferencias --
            usp_print('
                    <th class="th1">Operaci&oacute;n</th>');
        end if;

        ln_fila:= 1;
        ------ Operaciones del contrato -----
        For co in c_oper(ln_cod_contrato) loop

            ------- Total y Cantidad de Pagos por Operacion ----
            Select
                to_char( nvl(sum(a.monto_pago),0), '999,999,999,990.00' ),
                to_char( nvl(sum(decode(b.ind_eliminar,1,0,nvl(b.monto_pago,a.monto_pago))),0), '999,999,999,990.00' ),
                count(a.num_pago)
            into lv_total_progr_op, lv_total_pagar_op, ln_cont_pagos
            from
                reg_procesos.contrato_operacion_calendario a,
                (   Select x.id_operacion, x.num_pago, x.fec_pago, x.monto_pago, x.ind_eliminar
                    from reg_procesos.tmp_contrato_operacion_cal x
                    where
                        id_usuario     = session__userid
                        and id_motivo  = co.id_motivo
                        and id_op      = co.id_op
                ) b
            where
                a.id_operacion = b.id_operacion(+)
                and a.num_pago = b.num_pago(+)
                and a.id_operacion = co.id_operacion;

            usp_print('
                    <tr valign="top">
                        <td class="recuadro" rowspan="'||(ln_cont_pagos + 1)||'">
                            <table>
                                <tr>
                                    <td colspan="2" align="left"><b>'||co.des_motivo||'</b> ( '||co.f_operacion||' )</td>
                                </tr>
                                <tr>
                                    <td align="left">Programado :</td>
                                    <td align="left">'||lv_total_progr_op||'</td>
                                </tr>
                                <tr>
                                    <td align="left">A Pagar :</td>
                                    <td align="left">'||lv_total_pagar_op||'</td>
                                </tr>
                            </table>
                        </td>
                    </tr>');

            -------- Calendario por Operacion ---------

            for cc in c_cal(co.id_operacion,co.id_op,co.id_motivo,session__userid) loop
            begin
                if ag_reg_cal_modif is null then --- Muestra 'Modificar'
                    usp_print('
                    <tr>
                        <td align="center">'||cc.num_pago||'</td>
                        <td align="center">'||cc.fec_prog||'</td>
                        <td align="right">'||to_char(cc.monto_prog, '999,999,999,999.99')||'</td>
                        <td align="center">'||cc.fec_pago||'</td>
                        <td align="right">'||to_char(cc.monto_pago, '999,999,999,999.99')||'</td>');
                        if ln_contr_trans = 0 then -- Contrato sin transferencias --
                            usp_print('
                        <td align="center">
                            <img src="img/editar.gif" alt="Modificar Datos" style="cursor:hand" onclick="EditRow(this,'||co.id_motivo||co.id_op||cc.num_pago||')" />&#xa0;&#xa0;
                          <!--  <img src="'||gpk_eliminar||'" alt="Eliminar" style="cursor:hand" onclick="DeleteRow(this,'''||session__userid||''','||co.id_motivo||','||co.id_operacion||','||co.id_op||','||cc.num_pago||');"/>&#xa0;&#xa0; -->
                        </td>');
                        else
                            usp_print('
                        <td align="center">&nbsp;</td>');
                        end if;

                    usp_print('
                    </tr> ');
                else ------ Muestra 'Aceptar' o Vacio --------------
                    if ( ag_reg_cal_modif = trim(co.id_motivo||co.id_op||cc.num_pago) ) then
                        ------------ Fila que esta editandose -----
                        usp_print('
                    <tr>
                        <td align="center">'||cc.num_pago||'</td>
                        <td align="center">'||cc.fec_prog||'</td>
                        <td align="right">'||to_char(cc.monto_prog, '999,999,999,999.99')||'</td>
                        <td align="left" width="18%">
                        <div class="input-group datepicker" id="idDivTxtFechaIni">
                <div class="input-group-addon  add-on">
                     <span class="glyphicon glyphicon-calendar"></span>
                </div>
               <input type="text" name="fec_pago_mod" value="'||cc.fec_pago||'" style="width:98%" data-format="dd/MM/yyyy" class="form-control"/>
          </div>

                        </td>
                        <td align="left"><input name="monto_pago_mod" style="width:98%" align="right" value="'||cc.monto_pago||'"/></td>
                        <td align="center">
                            <img src="'||gpk_aceptar||'"  alt="Aceptar" style="cursor:hand" onclick="UpdateRow(this,'''||session__userid||''','||co.id_motivo||','||co.id_operacion||','||co.id_op||','||cc.num_pago||');"/>&#xa0;&#xa0;
                            <img src="'||gpk_eliminar||'" alt="Cancelar" style="cursor:hand" onclick="ag_reg_cal_modif.value='''';Refresh(this);"/>
                        </td>
                    </tr> ');
                    else ------------ Fila que No se edita -----
                        usp_print('
                    <tr>
                        <td align="center">'||cc.num_pago||'</td>
                        <td align="center">'||cc.fec_prog||'</td>
                        <td align="right">'||to_char(cc.monto_prog, '999,999,999,999.99')||'</td>
                        <td align="center">'||cc.fec_pago||'</td>
                        <td align="right">'||to_char(cc.monto_pago, '999,999,999,999.99')||'</td>
                        <td align="center">&nbsp;</td>
                    </tr> ');
                    end if;
                end if;
            end;
            end loop;
            ln_fila:= ln_fila + 1;

        end loop;
        usp_print('
                </table>
            </td>
        </tr>');

    end if;
    usp_print('
    </table>');

    ----------- Items para Resolucion Parcial ------------
    IF( ag_cod_tipo_resoucion is not null and ag_cod_tipo_resoucion = '2') THEN
        usp_print('

        <table width=100% class="table table-striped">');
            usp_print( PKU_PROCESOS_COMUN.f_get_subTitulo('Items del Contrato'));
            usp_print('
            <th class="th1">Resolver Items</th>
            <th class="th1">Item Nro.</th>
            <th class="th1">Descripci&oacute;n</th>
            <th class="th1">Monto</th>  
            <th class="th1">Fecha de Registro</th>');
            ln_fila:= 1;
            -------- Items del Contrato --------
            For ci in c_item_cont(ln_cod_contrato) Loop
                usp_print('
            <tr id="tr_'||ln_fila||'">
                <td align="center" width= "9%">
                    <input type="hidden"   name="row"            value="'||ln_fila||'"/>
                    <input type="hidden"   name="item"           value="'||ci.proc_item||'" />
                    <input type="checkbox" name="proc_item"      value="'||ci.proc_item||'" border="0"/>
                </td>
                <td align="center" width= "8%" >'||ci.proc_item||'</td>
                <td align="left"   width= "61%">'||ci.descripcion||'</td>
                <td align="center" width= "7%">'||ci.monto||'</td>
                <td align="center" width= "15%">'||to_char(ci.f_registro, 'dd/mm/yyyy HH:mi')||'</td>
            </tr>');
                ln_fila:= ln_fila + 1;
            End loop;
            usp_print('
        </table>');

    End If;


    usp_print('
    <input type="hidden" name="cant_items" value="'||(ln_fila-1)||'"/>
    <br/>');



  End;


PROCEDURE uspManResolucionDoView(
    session__N_CONVOCA         varchar2,
    ag_cod_resolucion          varchar2,
    ag_anhoentidad             varchar2,
    ag_proc_tipo               varchar2,
    ag_proc_desc               varchar2,
    ag_proc_sigla              varchar2,
    session__FileSingedHTTP    varchar2)
IS

  --------- Operaciones --------------
  Cursor c_oper(p_n_cod_contrato in number) is

            Select 1 id_motivo, 
                   'Contrato' des_motivo, 
                    to_char(c.f_contrato,'dd/mm/yyyy') f_operacion,
                    nvl(c.id_operacion_src,c.id_operacion) id_operacion1,
                    c.id_operacion id_operacion2
               from reg_procesos.contrato c
            where c.n_cod_contrato = p_n_cod_contrato
            order by 1;


    ------- Calendario de cada tipo operacion -------
    Cursor c_cal(p_id_operacion1 in number,p_id_operacion2 in number) is

    Select a.num_pago, a.codmoneda, a.monto_pago monto_pago1,a.fec_pago fec_pago1, b.monto_pago monto_pago2, b.fec_pago fec_pago2
      from

        (   Select a.num_pago, a.codmoneda, a.monto_pago,to_char(a.fec_pago,'dd/mm/yyyy') fec_pago
              from reg_procesos.contrato_operacion_calendario a
             where a.id_operacion = p_id_operacion1
        ) a,
        (   
            Select a.num_pago, a.codmoneda, a.monto_pago, to_char(a.fec_pago,'dd/mm/yyyy') fec_pago
              from reg_procesos.contrato_operacion_calendario a
              where a.id_operacion = p_id_operacion2
        ) b
    where a.num_pago = b.num_pago(+)
    order by 1;

    ------------ Items del Contrato ----------------
    Cursor c_item_cont( p_n_cod_contrato in number, p_n_cod_resolucion in number ) is
    Select
        ic.descripcion, i.n_cod_contrato, i.n_convoca, i.proc_item,
        to_char(i.monto,REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_dinero) monto,
        i.f_registro, i.f_ult_mod, i.n_cod_resolucion, i.cantidad, i.unm_codigo
    from
        reg_procesos.item_contrato i,
        reg_procesos.item_convoca ic
    where
        i.n_convoca = ic.n_convoca
        and i.proc_item = ic.proc_item
        and i.n_cod_resolucion = p_n_cod_resolucion
        and i.n_cod_contrato = p_n_cod_contrato;

    --------------- Variables ------------
    ln_n_convoca             number;
    ln_cod_contrato          number;
    ln_cod_resolucion        number;
    lv_des_tipo_resolucion   varchar2(250);
    lv_n_cod_resolucion      varchar2(10);
    lv_des_causa_resolucion  varchar2(250);
    lv_fec_resolucion        varchar2(20);
    ln_cod_tipo_resoucion    number;
    lv_n_contrato            REG_PROCESOS.contrato.n_contrato%type;
    lv_ruc_contratista       REG_PROCESOS.contrato.ruc_contratista%type;
    lv_nom_contratista       REG_PROCESOS.contrato.nom_contratista%type;
    lv_maxi                  varchar2(10);
    ln_cant_tipo             number;
    ln_ind_uso_siaf          number;
    ln_cont_pagos            number;
    ln_fila                  number;
    lv_total_pago_cont1      varchar2(20);
    lv_total_pago_cont2      varchar2(20);
    lv_total_pago_op1        varchar2(20);
    lv_total_pago_op2        varchar2(20);
    ln_icon_tipo_file        varchar2(100);
    row_documento_doc        reg_procesos.Convocatoria_Doc%rowtype;

Begin

    ln_cod_resolucion  := to_number(ag_cod_resolucion);
    ln_n_convoca       := to_number(session__N_CONVOCA);

    -------- Funciones Script -------
    REG_PROCESOS.PKU_GESTOR_CONT_FUNCIONES_JS_3.fValidaCadenas_JS;

    ---------- Datos del documento de la Resolucion -----------  
    BEGIN 

      SELECT d.* into row_documento_doc FROM REG_PROCESOS.CONTRATO_RESOLUCION  R INNER JOIN CONVOCATORIA_DOC D ON R.COD_DOC = D.COD_DOC  WHERE R.N_COD_RESOLUCION = ln_cod_resolucion;
      --mmautino: El dia 29.05.2015 se corrige en icono del documento que no se visualizaba
      SELECT replace('bootstrap/'||archivo.icon_tipo_file, 'jpg', 'png') INTO ln_icon_tipo_file FROM REG_PROCESOS.tipo_archivo archivo  WHERE archivo.cod_tipo_file = row_documento_doc.cod_tipo_file;

    EXCEPTION
           WHEN OTHERS THEN
                pku_ss_mod_contratos.f_msg_error('Error al intentar hallar los datos del documento','''doViewNulidad''');
                return;                
    END;

    ---------- Datos de  la Resolucion -----------
    BEGIN
        select n_cod_contrato, tr.des_tipo_resolucion,trim(to_char(n_cod_resolucion, '99999999')),tc.des_causa_resolucion,tr.cod_tipo_resoucion, to_char(fec_resolucion,'dd/mm/yyyy')
        into ln_cod_contrato, lv_des_tipo_resolucion,lv_n_cod_resolucion, lv_des_causa_resolucion,ln_cod_tipo_resoucion, lv_fec_resolucion
        from
            reg_procesos.contrato_resolucion c,
            reg_procesos.tipo_causa_resolucion tc,
            reg_procesos.tipo_resolucion_contrato tr
        where
            c.cod_causa_resoucion = tc.cod_causa_resoucion
            and c.cod_tipo_resolucion = tr.cod_tipo_resoucion
            and n_cod_resolucion = ln_cod_resolucion;
    EXCEPTION
          WHEN OTHERS THEN
                pku_ss_mod_contratos.f_msg_error('Error al intentar hallar los datos de la resolucion','''doViewNulidad''');

    END;

    ----- Obtener Datos del Contrato ----
    BEGIN
        Select c.n_contrato, c.ruc_contratista, c.nom_contratista into lv_n_contrato, lv_ruc_contratista, lv_nom_contratista from REG_PROCESOS.contrato c where c.n_cod_contrato = ln_cod_contrato;

    EXCEPTION
        WHEN OTHERS THEN
                pku_ss_mod_contratos.f_msg_error('Error al intentar hallar los datos del Contrato','''doViewNulidad''');
    END;

    select max(trim(to_char(c.proc_item, '99999999'))) into lv_maxi from reg_procesos.item_contrato c where  c.n_cod_contrato = ln_cod_contrato;

    -------- Titulos ------------
    usp_print('
    <input type="hidden" name="ag_n_convoca"        value="'||ln_n_convoca||'"/>
    <input type="hidden" name="ag_cod_contrato"     value="'||ln_cod_contrato||'"/>
    <input type="hidden" name="ag_cod_resolucion"   value="'||ln_cod_resolucion||'"/>
    <input type="hidden" name="ag_anhoentidad"      value="'||ag_anhoentidad||'"/>
    <input type="hidden" name="ag_proc_tipo"        value="'||ag_proc_tipo||'"/>
    <input type="hidden" name="ag_proc_desc"        value="'||ag_proc_desc||'"/>
    <input type="hidden" name="ag_proc_sigla"       value="'||ag_proc_sigla||'"/>

    <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
        <tr>');
    usp_print(
           PKU_SS_UTILES.f_get_titulo_contrato ( ln_cod_contrato, 'Nulidad / Resoluci&oacute;n del Contrato u Orden de Compra o Servicios' ,'Nulidad / Resoluci&oacute;n del Contrato u Orden de Compra o Servicios ')
    );
    usp_print('
            <td align="right" valign=top width="50%">
                <input type="button" value="Volver" OnClick="thisform.scriptdo.value=''doViewNulidad'';thisform.submit();"/>
            </td>
        </tr>
    </table>
    <br>
    <table width=100% class="table table-striped">');
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('N&uacute;mero del Contrato (u Orden de Compra o Servicio)',
                '<input type="text" name="n_contrato" readonly style="width:98%" value="'||lv_n_contrato||'"/>',
                '.'));

    --------------  Cantidad de Resoluciones ----------------
    Select count(cod_tipo_resolucion) into ln_cant_tipo
    from reg_procesos.contrato_resolucion
    where n_cod_contrato = ln_cod_contrato and cod_tipo_resolucion = 2;

    -------------- Obtener el indicador del SIAF ----------------
    BEGIN
        SELECT ep.ind_uso_siaf into ln_ind_uso_siaf
          FROM reg_procesos.entidadue_anho_tipo_proceso ep,
               reg_procesos.convocatorias c,
               reg_procesos.contrato cnt,
               reg_procesos.contrato_resolucion cr
        WHERE  ep.eue_codigo  = c.codconsucode
            and ep.eue_anho   = c.anhoentidad
            and c.n_convoca   = cnt.n_convoca
            and cnt.n_cod_contrato   = cr.n_cod_contrato
            and cr.n_cod_resolucion  = ln_cod_resolucion
            and c.proc_tipo   = ep.tip_codigo;
    EXCEPTION
       WHEN OTHERS THEN
                pku_ss_mod_contratos.f_msg_error('Error al intentar hallar los datos de envio al SIAF','''doViewNulidad''');

    END;
   --mmautino: El dia 29.05.2015 se corrige la ruta del archivo para que se visualice el documento de nulidad- Formato 1642_OP_SEACE2_CON
   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Documento de Resoluci&oacute;n',
                   row_documento_doc.nro_doc ||' <br> ' || 
                   case when row_documento_doc.doc_url is not null then '<a target=_blank href="'||url_azure_app||session__FileSingedHTTP||REPLACE(row_documento_doc.doc_url, '\', '/')||'"> <img src="'||ln_icon_tipo_file||'" border="0" width="25" height="25"/></a>' end ||
                   case when row_documento_doc.fec_upload  is not null then ' Registrado el '||row_documento_doc.fec_upload end  ,'.'));
   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Fecha del Documento de Resoluci&oacute;n',
                '<input type="text" name="fec_res" readonly style="width:98%" value="'||lv_fec_resolucion||'"/>',
                '.'));

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Alcance de la Resoluci&oacute;n',
                '<input type="text" name="tipo_res" readonly style="width:98%" value="'||trim(lv_des_tipo_resolucion)||'"/>',
                '.'));

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Causal de la Resoluci&oacute;n',
                '<input type="text" name="causa_res" readonly style="width:98%" value="'||trim(lv_des_causa_resolucion)||'"/>',
                '.'));


    ---------- Calendario del Contrato ----------
    IF  ln_ind_uso_siaf = 1 THEN
        ------- Total Pagos del Contrato----
        Select to_char(nvl(sum(a.monto_pago),0),REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_dinero) into  lv_total_pago_cont1
        from reg_procesos.contrato_operacion_calendario a
        where a.id_operacion in (
                        Select nvl(c.id_operacion_src,c.id_operacion)
                        from reg_procesos.contrato c
                        where c.n_cod_contrato = ln_cod_contrato

        );

        ------- Total Pagos del Contrato----
        Select to_char(nvl(sum(a.monto_pago),0),REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_dinero) into  lv_total_pago_cont2
        from reg_procesos.contrato_operacion_calendario a
        where a.id_operacion in (
                       select co.id_operacion 
                         from reg_procesos.contrato_operacion co, reg_procesos.contrato c
                        where c.n_cod_contrato = co.n_cod_contrato
                          and co.n_cod_resolucion = ln_cod_resolucion
                          and co.cod_operacion_contrato = 1
        );

        usp_print('
        <tr>
            <td class=c1>
                Calendario
            </td>
            <td colspan="2" class=c2>
                <table id="cal_idtable" width=100% class="table table-hover">
                    <th class="th1">Operación</th>
                    <th class="th1">Nro.</th>
                    <th class="th1">Fecha Prog.</th>
                    <th class="th1" align="center">Monto Progra.</th>
                    <th class="th1">Fecha Pago</th>
                    <th class="th1" align="center">Monto Pago</th>');
        ln_fila:= 1;

        ------ Operaciones del contrato -----
        for co in c_oper( ln_cod_contrato ) loop
            ------- Total y Cantidad de Pagos del Contrato----
            Select to_char(nvl(sum(a.monto_pago),0),REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_dinero),count(a.num_pago)
              into lv_total_pago_op1, ln_cont_pagos
              from reg_procesos.contrato_operacion_calendario a
             where a.id_operacion = co.id_operacion1;

            ------- Total y Cantidad de Pagos de la Resolucion ----
            Select to_char(nvl(sum(a.monto_pago),0),REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_dinero)
              into lv_total_pago_op2
              from reg_procesos.contrato_operacion_calendario a
             where a.id_operacion = co.id_operacion2;

            usp_print('
                    <tr valign="top">
                        <td class="recuadro" rowspan="'||(ln_cont_pagos + 1)||'">
                            <table>
                                <tr>
                                    <td colspan="2" align="center"><b>'||co.des_motivo||'</b> ( '||co.f_operacion||' )</td>
                                </tr>
                                <tr>
                                    <td align="left">Programado : </td>
                                    <td align="right">'||lv_total_pago_op1||'</td>
                                </tr>
                                <tr>
                                    <td align="left">A Pagar : </td>
                                    <td align="right">'||lv_total_pago_op2||'</td>
                                </tr>
                            </table>
                        </td>
                    </tr>');
            -------- Calendario por Operacion ---------

            for cc in c_cal(co.id_operacion1,co.id_operacion2) loop

                usp_print('
                    <tr>
                        <td align="center">'||cc.num_pago||'</td>
                        <td align="center">'||cc.fec_pago1||'</td>
                        <td align="right">'||to_char(cc.monto_pago1,REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_dinero)||'</td>
                        <td align="center">'||cc.fec_pago2||'</td>
                        <td align="right">'||to_char(cc.monto_pago2,REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_dinero)||'</td>
                    </tr>');
            end loop;

            ln_fila:= ln_fila + 1;

        end loop;
        usp_print('
                </table>
            </td>
        </tr>');
    end if;
    usp_print(
            PKU_PROCESOS_COMUN.f_get_subTitulo('Items del Contrato') );
    usp_print('
    </table>
    <table id="cal_idtable" width=100% class="table table-striped">
        <th class="th1">Resolver Items</th>
        <th class="th1">Item Nro.</th>
        <th class="th1">Descripci&oacute;n</th>
        <th class="th1">Monto</th>
        <th class="th1">Fecha de Registro</th>');
    ln_fila:= 1;
    -------- Items del Contrato --------

    FOR ci in c_item_cont( ln_cod_contrato, ln_cod_resolucion) loop
        usp_print('
        <tr id="tr_'||ln_fila||'">
            <td align="center" width= "9%">
                <input type="hidden" name="row" value="'||ln_fila||'"/>
                <input type="checkbox" name="proc_item" value="'||ci.proc_item||'" border="0"');
        if ci.n_cod_resolucion is not null then
            usp_print(' checked disabled ');
        end if;
        usp_print('/>
            </td>
            <td align="center" width= "8%">'||ci.proc_item||'</td>
            <td align="left" width= "61%">'||ci.descripcion||'</td>
            <td align="center" width= "7%">'||ci.monto||'</td>
            <td align="center" width= "15%">'||to_char(ci.f_registro, 'dd/mm/yyyy HH:mi')||'</td>
        </tr>');
        ln_fila:= ln_fila + 1;
    end loop;

    usp_print('
    </table>');

End;




 PROCEDURE uspLisResolucionDoView(
    session__userid             varchar2,
    session__N_CONVOCA          varchar2,
    session__COD_CONTRATO       varchar2,
    session__PUBLICADO          varchar2)
IS

    ------- Listado de Resoluciones -------
    Cursor c_resoluciones(p_n_cod_contrato in number, p_n_convoca in number) is
    Select distinct
        co.n_convoca, r.n_cod_contrato, r.estado_contrato tipo,
        trim(to_char(r.n_cod_resolucion,'99999999')) n_cod_resolucion,
        tr.des_tipo_resolucion, tc.des_causa_resolucion,
        to_char(r.fec_resolucion,'dd/mm/yyyy') fec_resolucion
    from
        REG_PROCESOS.convocatorias co,
        REG_PROCESOS.contrato c,
        REG_PROCESOS.contrato_resolucion r,
        REG_PROCESOS.tipo_resolucion_contrato tr,
        REG_PROCESOS.tipo_causa_resolucion tc
    where
        co.n_convoca              = c.n_convoca
        and c.n_cod_contrato      = r.n_cod_contrato
        and r.cod_tipo_resolucion = tr.cod_tipo_resoucion
        and r.cod_causa_resoucion = tc.cod_causa_resoucion
        and c.n_convoca           = p_n_convoca
        and r.n_cod_contrato      = p_n_cod_contrato
        order by n_cod_resolucion;

    ln_n_convoca         number;
    ln_cod_contrato      number;

    ln_Cont_Fila         number;
    ln_cant_res          number;
    ln_estado            number;
    ln_color             varchar2(5000);

    ln_modulo number;        -- (1/3) 12.09.2020 , permite verificar si las acciones sobre el contrato deben estas habilitados

BEGIN

    if session__COD_CONTRATO is not null then
        ln_n_convoca     := session__N_CONVOCA;
        ln_cod_contrato  := session__COD_CONTRATO;
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

    ---- obtenemos la cantidad de items sin resolver del contrato 
    BEGIN
        select count(proc_item) into ln_cant_res from reg_procesos.item_contrato where n_cod_resolucion is null and n_cod_contrato = ln_cod_contrato;
    exception
        when no_data_found then
            reg_procesos.pku_ss_mod_contratos.f_msg_error('Error al intentar hallar la cantidad de items no resueltos del Contrato','''doViewNulidad''');

    END;

    usp_print('
    <input type="hidden" name="ag_cod_resolucion"    value=""/>


    <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
    <tr>');

    usp_print(
      PKU_SS_UTILES.f_get_titulo_contrato ( ln_cod_contrato, 'Nulidad / Resoluci&oacute;n del Contrato u Orden de Compra o Servicios' ,'Nulidad / Resoluci&oacute;n del Contrato u Orden de Compra o Servicios ')
      );    

    usp_print('
            <td align="right" valign=top width="50%">');
    -- (3/3) 12.09.2020, obtiene el indicador que verifica que las acciones esten habilitadas
    if ln_modulo = 1 then 
        IF ln_cant_res > 0 THEN
            usp_print('
                    <input type="button" value="Crear Nulidad / Resolución" OnClick="validaInsert()"/>');
        END IF;
    end if;

    usp_print(' &nbsp;
            </td>
        </tr>
    </table>
    <br>
    <table border="0" width=100% class="table table-striped">
        <th class="th1">Nro. Operaci&oacute;n</th>
        <th class="th1">Tipo Operaci&oacute;n</th>
        <th class="th1">Tipo Resoluci&oacute;n / Anulaci&oacute;n</th>
        <th class="th1">Causal</th>  
        <th class="th1">Fecha de la Operaci&oacute;n</th>');

    ------ Listado de Resoluciones ---
    ln_Cont_Fila:=1;

    FOR cr in c_resoluciones(ln_cod_contrato,ln_n_convoca) LOOP

        IF mod(ln_Cont_Fila,2) = 0 THEN 
            ln_color := 'bgcolor="#ECE9D8"';
        ELSE
            ln_color := '';
        END IF;

        usp_print('
        <tr '||ln_color||'>
            <td align="center">
                <b>'||makea('ag_n_convoca='||ln_n_convoca||'&ag_cod_resolucion='||cr.n_cod_resolucion||'&ag_id_usuario='||session__userid||'&scriptdo=doViewNulidadDetalle',cr.n_cod_resolucion)||'<b>
            </td>');

            IF cr.tipo = 1 THEN
                usp_print('<td align="center">Resolucion</td>');
            ELSE
                usp_print('<td align="center">Anulacion</td>');
            END IF;

            usp_print('
            <td align="center">'||cr.des_tipo_resolucion||'</td>
            <td align="center">'||cr.des_causa_resolucion||'</td>
            <td align="center">'||cr.fec_resolucion||'</td>
        </tr>');

        ln_Cont_Fila:= ln_Cont_Fila + 1;

    END LOOP;

    usp_print('</table>');

    ---------- Java Script ---------------
    usp_print('
    <script language="javascript">
        function ver(nconvoca,codresolucion)
        {
            thisform.ag_n_convoca.value=nconvoca;
            thisform.ag_cod_resolucion.value=codresolucion;
            thisform.scriptdo.value="PKU_SS_CONTRATOS2.uspManResolucionDoView";
            thisform.submit();
            return true;
        }

        function validaInsert()
        {
            var estado = thisform.ag_estado.value
            if ( estado == 1 )
            {
                alert("No se puede crear nuevas resoluciones por estar el contrato anulado");
                return;
            }
            else
            {
                thisform.scriptdo.value = "doNewNulidad";
                thisform.submit();
                return true;
            }
        }
    </script>');

    select count(1) into ln_estado from REG_PROCESOS.contrato_resolucion where n_cod_contrato = ln_cod_contrato and estado_contrato = 2;

    IF (ln_estado = 0) THEN
        usp_print('<input type="hidden" value="0" name="ag_estado">');
    ELSE
        usp_print('<input type="hidden" value="'||ln_estado||'" name="ag_estado">');
    END IF;

EXCEPTION 

    WHEN  others THEN
        raise_application_error(-20000,'Se detecto una incorrecta asignacion de valores en los argumentos');

END;

PROCEDURE uspResolucionDoCancel(
    session__userid         varchar2)
Is
Begin

    --------- Borrar tabla temporal ----
    delete from reg_procesos.tmp_contrato_operacion_cal where id_usuario = session__userid;
    commit;


    usp_print('
    <script language="javascript">
        thisform.scriptdo.value="doViewNulidad";
        thisform.submit();
    </script>');
End;





end PKU_GESTOR_CONT_NULID_RESOL;
/
