package pe.gob.osce.seace.procesos.regprocesos.web.jsf;

import java.util.List;

import javax.ejb.EJB;
import javax.faces.event.ActionEvent;

import pe.gob.osce.seace.procesos.regprocesos.ejb.service.ConciliacionLaudoServiceLocal;
import pe.gob.osce.seace.procesos.regprocesos.vo.ArbitrajeLaudoVO;
import pe.gob.osce.seace.procesos.regprocesos.vo.ConciliacionLaudoVO;
import pe.gob.osce.seace.procesos.regprocesos.vo.DatosContratoVO;

/***********************************************************************
 * 	Modificación
 *  ====================================================================
 *  Id		autor		#Incidencia				fecha		Descripción
 *  ====================================================================
 *  001		mchileno	Descarga de archivos  	18/11/2020  PROYECTO MIGRACION	
 * ********************************************************************/
public class ConciliacionLaudoBean {

	@EJB
	private ConciliacionLaudoServiceLocal conciliacionLaudoServiceLocal;
	
	List<ConciliacionLaudoVO> listaConciliaciones;
	List<ArbitrajeLaudoVO> listaArbitrajes;

	ConciliacionLaudoVO conciliacionLaudoVO;
	DatosContratoVO datosContratoVO;
	
	/*variables*/
	
	private int numConcialiaciones = 0;
	private int numArbitrajes = 0;
	//private String baseurldocumentos = "http://zonasegura.seace.gob.pe";
	/*001*/
	private String baseurldocumentos = "https://zonasegura2.seace.gob.pe";
	/*001*/
	private String baseurlImages = "http://www2.seace.gob.pe/";
	
	
	public ConciliacionLaudoBean(){
		conciliacionLaudoVO = new ConciliacionLaudoVO();
		datosContratoVO = new DatosContratoVO();
	}
	
	public void listarConciliacion(ActionEvent event){
		Long var = 534994L;
		try {
			listaConciliaciones = conciliacionLaudoServiceLocal.listaConciliacion(var);
			listaArbitrajes = conciliacionLaudoServiceLocal.listaArbitrajes(var);
			datosContratoVO = conciliacionLaudoServiceLocal.detalleContrato(var);
			numConcialiaciones = listaConciliaciones.size();
			numArbitrajes = listaArbitrajes.size();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}


	
	
	/*GETTER AND SETTER*/
	
	public List<ConciliacionLaudoVO> getListaConciliaciones() {
		return listaConciliaciones;
	}

	public void setListaConciliaciones(List<ConciliacionLaudoVO> listaConciliaciones) {
		this.listaConciliaciones = listaConciliaciones;
	}

	public ConciliacionLaudoVO getConciliacionLaudoVO() {
		return conciliacionLaudoVO;
	}

	public void setConciliacionLaudoVO(ConciliacionLaudoVO conciliacionLaudoVO) {
		this.conciliacionLaudoVO = conciliacionLaudoVO;
	}

	public int getNumConcialiaciones() {
		return numConcialiaciones;
	}

	public void setNumConcialiaciones(int numConcialiaciones) {
		this.numConcialiaciones = numConcialiaciones;
	}

	public String getBaseurldocumentos() {
		return baseurldocumentos;
	}

	public void setBaseurldocumentos(String baseurldocumentos) {
		this.baseurldocumentos = baseurldocumentos;
	}

	public String getBaseurlImages() {
		return baseurlImages;
	}

	public void setBaseurlImages(String baseurlImages) {
		this.baseurlImages = baseurlImages;
	}

	public List<ArbitrajeLaudoVO> getListaArbitrajes() {
		return listaArbitrajes;
	}

	public void setListaArbitrajes(List<ArbitrajeLaudoVO> listaArbitrajes) {
		this.listaArbitrajes = listaArbitrajes;
	}


	public DatosContratoVO getDatosContratoVO() {
		return datosContratoVO;
	}


	public void setDatosContratoVO(DatosContratoVO datosContratoVO) {
		this.datosContratoVO = datosContratoVO;
	}

	public int getNumArbitrajes() {
		return numArbitrajes;
	}

	public void setNumArbitrajes(int numArbitrajes) {
		this.numArbitrajes = numArbitrajes;
	}

}
