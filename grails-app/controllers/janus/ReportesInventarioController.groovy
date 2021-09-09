package janus

import com.lowagie.text.Document
import com.lowagie.text.Element
import com.lowagie.text.Font
import com.lowagie.text.Image
import com.lowagie.text.PageSize
import com.lowagie.text.Paragraph
import com.lowagie.text.pdf.PdfPCell
import com.lowagie.text.pdf.PdfPTable
import com.lowagie.text.pdf.PdfWriter

import java.awt.Color

class ReportesInventarioController {

    def dbConnectionService
    def reportesPdfService

    def reportes() {

    }

    def listaObra() {
        println "listaObra" + params
        def listaObra = ['obranmbr', 'obracdgo']
        def datos;
        def select = "select obra.obra__id, obracdgo, obranmbr " +
                "from obra "
        def txwh = "where obra.obra__id in (select obra__id from comp) "
        def sqlTx = ""
        def bsca = listaObra[params.buscarPor.toInteger() - 1]
        def ordn = listaObra[params.ordenar.toInteger() - 1]
        txwh += " and $bsca ilike '%${params.criterio}%'"

        sqlTx = "${select} ${txwh} order by ${ordn} limit 100 ".toString()
//        println "sql: $sqlTx"

        def cn = dbConnectionService.getConnection()
        datos = cn.rows(sqlTx)
        println "data: ${datos}"
        [data: datos, tipo: params.tipo, consumo: params.consumo]
    }

    def listaComposicion() {
        println "listaCompo" + params
        def listaObra = ['obranmbr', 'obracdgo']
        def datos;
        def select = "select obra.obra__id, obracdgo, obranmbr " +
                "from obra "
        def txwh = "where obra.obra__id in (select obra__id from comp) "
        def sqlTx = ""
        def bsca = listaObra[params.buscarPor.toInteger() - 1]
        def ordn = listaObra[params.ordenar.toInteger() - 1]
        txwh += " and $bsca ilike '%${params.criterio}%'"

        sqlTx = "${select} ${txwh} order by ${ordn} limit 100 ".toString()
//        println "sql: $sqlTx"

        def cn = dbConnectionService.getConnection()
        datos = cn.rows(sqlTx)
        println "data: ${datos}"
        [data: datos, tipo: params.tipo, consumo: params.consumo]
    }

    def listaDiferencia() {
        println "listaDif" + params
        def listaObra = ['obranmbr', 'obracdgo']
        def datos;
        def select = "select obra.obra__id, obracdgo, obranmbr " +
                "from obra "
        def txwh = "where obra.obra__id in (select obra__id from comp) "
        def sqlTx = ""
        def bsca = listaObra[params.buscarPor.toInteger() - 1]
        def ordn = listaObra[params.ordenar.toInteger() - 1]
        txwh += " and $bsca ilike '%${params.criterio}%'"

        sqlTx = "${select} ${txwh} order by ${ordn} limit 100 ".toString()
//        println "sql: $sqlTx"

        def cn = dbConnectionService.getConnection()
        datos = cn.rows(sqlTx)
        println "data: ${datos}"
        [data: datos, tipo: params.tipo, consumo: params.consumo]
    }


    def reporteCostoActual() {
        println("params " + params)

        def usuario = Persona.get(session.usuario.id)
        def empresa = usuario.empresa
        def obra = Obra.get(params.obra)

        def sql = "select * from rp_consumo(${params.obra.toInteger()})"
        def cn = dbConnectionService.getConnection()
        def datos = cn.rows(sql)

        println("sql " + sql)

        def prmsHeaderHoja = [border: Color.WHITE]
        def prmsFila = [border: Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
        def prmsFilaIzquierda = [border: Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE]
        def prmsFilaDerecha = [border: Color.WHITE, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE]
        def prmsHeaderHoja2 = [border: Color.WHITE, colspan: 9]
        def prmsHeader = [border: Color.WHITE, colspan: 7, bg: new Color(73, 175, 205),
                          align : Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
        def prmsHeader2 = [border: Color.WHITE, colspan: 3, bg: new Color(73, 175, 205),
                           align : Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
        def prmsCellHead = [border: Color.WHITE, bg: new Color(73, 175, 205),
                            align : Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
        def prmsCellCenter = [border: Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
        def prmsCellRight = [border: Color.BLACK, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE]
        def prmsCellLeft = [border: Color.WHITE, valign: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE]
        def prmsSubtotal = [border: Color.BLACK, colspan: 6,
                            align : Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE]
        def prmsNum = [border: Color.BLACK, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE]

        def celdaCabecera = [border: Color.BLACK, bg: new Color(220, 220, 220), align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, bordeBot: "1"]

        Font times12bold = new Font(Font.TIMES_ROMAN, 12, Font.BOLD)
        Font times14bold = new Font(Font.TIMES_ROMAN, 14, Font.BOLD)
        Font times10bold = new Font(Font.TIMES_ROMAN, 10, Font.BOLD)
        Font times10normal = new Font(Font.TIMES_ROMAN, 10, Font.NORMAL)
        Font times8bold = new Font(Font.TIMES_ROMAN, 8, Font.BOLD)
        Font times8normal = new Font(Font.TIMES_ROMAN, 8, Font.NORMAL)
        Font times7bold = new Font(Font.TIMES_ROMAN, 7, Font.BOLD)
        Font times7normal = new Font(Font.TIMES_ROMAN, 7, Font.NORMAL)
        Font times10boldWhite = new Font(Font.TIMES_ROMAN, 10, Font.BOLD);
        Font times8boldWhite = new Font(Font.TIMES_ROMAN, 8, Font.BOLD)

        times8boldWhite.setColor(Color.WHITE)
        times10boldWhite.setColor(Color.WHITE)

        def fonts = [times12bold     : times12bold, times10bold: times10bold, times8bold: times8bold,
                     times10boldWhite: times10boldWhite, times8boldWhite: times8boldWhite, times8normal: times8normal, times10normal: times10normal]

        def baos = new ByteArrayOutputStream()
        def name = "reporteCostoActual_" + new Date().format("ddMMyyyy_hhmm") + ".pdf";
        def logoPath = servletContext.getRealPath("/") + "images/logos/${empresa?.id}/logo_reportes.png"
        Image logo = Image.getInstance(logoPath);
        logo.scalePercent(70)
        logo.setAlignment(Image.MIDDLE | Image.TEXTWRAP)

        Document document
//        document = new Document(PageSize.A4.rotate());
        document = new Document(PageSize.A4);

        document.setMargins(40, 40, 20, 25);
        def pdfw = PdfWriter.getInstance(document, baos);
        document.open();
        document.addTitle("Composicion " + new Date().format("dd_MM_yyyy"));
        document.addSubject("Generado por el sistema Obras");
        document.addKeywords("documentosObra, obras, costoActual");
        document.addAuthor("OBRAS");
        document.addCreator("Tedein SA");

        Paragraph headers = new Paragraph();
        headers.setAlignment(Element.ALIGN_CENTER);
        headers.add(new Paragraph(empresa?.nombre?.toUpperCase(), times12bold));
        headers.add(new Paragraph(" ", times10bold));
        headers.add(new Paragraph(empresa?.direccion, times10bold));
        headers.add(new Paragraph("Teléfono: " + (empresa?.telefono ? empresa?.telefono : ''), times10bold));
        headers.add(new Paragraph("Email: " + (empresa?.email ? empresa?.email : ''), times10bold));
        headers.add(new Paragraph(" ", times10bold));
        headers.add(new Paragraph(empresa?.lugar + " -  Ecuador", times10bold));
        headers.add(new Paragraph(" ", times10bold));

        Paragraph headersRemi = new Paragraph();
        headersRemi.setAlignment(Element.ALIGN_CENTER);
        headersRemi.add(new Paragraph("OBRA: " + obra?.nombre, times10bold));
        headersRemi.add(new Paragraph("COSTO ACTUAL", times10bold));
        headersRemi.add(new Paragraph(" ", times10bold));

        //COMPOSICION
//        PdfPTable tablaEquipos = new PdfPTable(8);
        PdfPTable tablaEquipos = new PdfPTable(6);
        tablaEquipos.setWidthPercentage(100);
//        tablaEquipos.setWidths(arregloEnteros([12, 32, 8, 10, 10, 10, 10, 8]))
        tablaEquipos.setWidths(arregloEnteros([12, 50, 8, 10, 10, 10]))

        reportesPdfService.addCellTb(tablaEquipos, new Paragraph("CÓDIGO", times7bold), celdaCabecera)
        reportesPdfService.addCellTb(tablaEquipos, new Paragraph("ITEM", times7bold), celdaCabecera)
        reportesPdfService.addCellTb(tablaEquipos, new Paragraph("UNIDAD", times7bold), celdaCabecera)
//        reportesPdfService.addCellTb(tablaEquipos, new Paragraph("COMP. CANT.", times7bold), celdaCabecera)
        reportesPdfService.addCellTb(tablaEquipos, new Paragraph("REQUI. CANT", times7bold), celdaCabecera)
        reportesPdfService.addCellTb(tablaEquipos, new Paragraph("REQUI. PRECIO", times7bold), celdaCabecera)
        reportesPdfService.addCellTb(tablaEquipos, new Paragraph("VALOR", times7bold), celdaCabecera)
//        reportesPdfService.addCellTb(tablaEquipos, new Paragraph("DIF.", times7bold), celdaCabecera)

        datos.eachWithIndex { r, i ->
            if(r?.cnsmcntd){
                reportesPdfService.addCellTb(tablaEquipos, new Paragraph(r?.itemcdgo, times8normal), prmsFilaIzquierda)
                reportesPdfService.addCellTb(tablaEquipos, new Paragraph(r?.itemnmbr, times8normal), prmsFilaIzquierda)
                reportesPdfService.addCellTb(tablaEquipos, new Paragraph(r?.unddcdgo, times8normal), prmsFila)
//            reportesPdfService.addCellTb(tablaEquipos, new Paragraph(numero(r?.compcntd, 3)?.toString(), times8normal), prmsFilaDerecha)
                reportesPdfService.addCellTb(tablaEquipos, new Paragraph(numero(r?.cnsmcntd, 3)?.toString(), times8normal), prmsFilaDerecha)
                reportesPdfService.addCellTb(tablaEquipos, new Paragraph(numero(r?.cnsmpcun, 4)?.toString(), times8normal), prmsFilaDerecha)
                reportesPdfService.addCellTb(tablaEquipos, new Paragraph(numero(r?.cnsmvlor, 4)?.toString(), times8normal), prmsFilaDerecha)
//            if (r?.cnsmcntd) {
//                reportesPdfService.addCellTb(tablaEquipos, new Paragraph(numero(r?.cnsmcntd ? (r?.cnsmcntd - r?.compcntd) : 0, 3)?.toString(), times8normal), prmsFilaDerecha)
//            } else {
//                reportesPdfService.addCellTb(tablaEquipos, new Paragraph('', times8normal), prmsFilaIzquierda)
//            }
            }
        }

        PdfPTable tablaHeader = new PdfPTable(2);
        tablaHeader.setWidthPercentage(100);
        tablaHeader.setWidths(arregloEnteros([50, 50]))

        addCellTabla(tablaHeader, logo, prmsCellLeft)
        addCellTabla(tablaHeader, headers, prmsCellCenter)

//        document.add(tablaHeader)
//        document.add(logo)
        document.add(tablaHeader)
        document.add(headersRemi)
        document.add(tablaEquipos)

        document.close();
        pdfw.close()
        byte[] b = baos.toByteArray();
        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + name)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }

    private static int[] arregloEnteros(array) {
        int[] ia = new int[array.size()]
        array.eachWithIndex { it, i ->
            ia[i] = it.toInteger()
        }
        return ia
    }

    private static void addCellTabla(PdfPTable table, paragraph, params) {
        PdfPCell cell = new PdfPCell(paragraph);
        if (params.height) {
            cell.setFixedHeight(params.height.toFloat());
        }
        if (params.border) {
            cell.setBorderColor(params.border);
        }
        if (params.bg) {
            cell.setBackgroundColor(params.bg);
        }
        if (params.colspan) {
            cell.setColspan(params.colspan);
        }
        if (params.align) {
            cell.setHorizontalAlignment(params.align);
        }
        if (params.valign) {
            cell.setVerticalAlignment(params.valign);
        }
        if (params.w) {
            cell.setBorderWidth(params.w);
            cell.setUseBorderPadding(true);
        }
        if (params.bwl) {
            cell.setBorderWidthLeft(params.bwl.toFloat());
            cell.setUseBorderPadding(true);
        }
        if (params.bwb) {
            cell.setBorderWidthBottom(params.bwb.toFloat());
            cell.setUseBorderPadding(true);
        }
        if (params.bwr) {
            cell.setBorderWidthRight(params.bwr.toFloat());
            cell.setUseBorderPadding(true);
        }
        if (params.bwt) {
            cell.setBorderWidthTop(params.bwt.toFloat());
            cell.setUseBorderPadding(true);
        }
        if (params.bcl) {
            cell.setBorderColorLeft(params.bcl);
            cell.setUseVariableBorders(true);
        }
        if (params.bcb) {
            cell.setBorderColorBottom(params.bcb);
            cell.setUseVariableBorders(true);
        }
        if (params.bcr) {
            cell.setBorderColorRight(params.bcr);
            cell.setUseVariableBorders(true);
        }
        if (params.bct) {
            cell.setBorderColorTop(params.bct);
            cell.setUseVariableBorders(true);
        }
        if (params.padding) {
            cell.setPadding(params.padding.toFloat());
        }
        if (params.pl) {
            cell.setPaddingLeft(params.pl.toFloat());
        }
        if (params.pr) {
            cell.setPaddingRight(params.pr.toFloat());
        }
        if (params.pt) {
            cell.setPaddingTop(params.pt.toFloat());
        }
        if (params.pb) {
            cell.setPaddingBottom(params.pb.toFloat());
        }
        if (params.bordeTop) {
            cell.setBorderWidthTop(1)
            cell.setBorderWidthLeft(0)
            cell.setBorderWidthRight(0)
            cell.setBorderWidthBottom(0)
            cell.setPaddingTop(7);
        }
        if (params.bordeBot) {
            cell.setBorderWidthBottom(1)
            cell.setBorderWidthLeft(0)
            cell.setBorderWidthRight(0)
            cell.setPaddingBottom(7)

            if (!params.bordeTop) {
                cell.setBorderWidthTop(0)
            }
        }
        table.addCell(cell);
    }

    private String numero(num, decimales, cero) {
        if (num == 0 && cero.toString().toLowerCase() == "hide") {
            return " ";
        }
        if (decimales == 0) {
            return formatNumber(number: num, minFractionDigits: decimales, maxFractionDigits: decimales, locale: "ec")
        } else {
            def format
            if (decimales == 2) {
                format = "##,##0"
            } else if (decimales == 3) {
                format = "##,###0"
            }
            return formatNumber(number: num, minFractionDigits: decimales, maxFractionDigits: decimales, locale: "ec", format: format)
        }
    }

    private String numero(num, decimales) {
        return numero(num, decimales, "show")
    }

    private String numero(num) {
        return numero(num, 3)
    }

    def reporteDiferencia() {
//        println("params " + params)

        def usuario = Persona.get(session.usuario.id)
        def empresa = usuario.empresa
        def obra = Obra.get(params.obra)

        def sql = "select * from rp_consumo(${params.obra.toInteger()})"
        def cn = dbConnectionService.getConnection()
        def datos = cn.rows(sql)

//        println("sql " + sql)

        def prmsHeaderHoja = [border: Color.WHITE]
        def prmsFila = [border: Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
        def prmsFilaIzquierda = [border: Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE]
        def prmsFilaDerecha = [border: Color.WHITE, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE]
        def prmsHeaderHoja2 = [border: Color.WHITE, colspan: 9]
        def prmsHeader = [border: Color.WHITE, colspan: 7, bg: new Color(73, 175, 205),
                          align : Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
        def prmsHeader2 = [border: Color.WHITE, colspan: 3, bg: new Color(73, 175, 205),
                           align : Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
        def prmsCellHead = [border: Color.WHITE, bg: new Color(73, 175, 205),
                            align : Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
        def prmsCellCenter = [border: Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
        def prmsCellRight = [border: Color.BLACK, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE]
        def prmsCellLeft = [border: Color.WHITE, valign: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE]
        def prmsSubtotal = [border: Color.BLACK, colspan: 6,
                            align : Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE]
        def prmsNum = [border: Color.BLACK, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE]

        def celdaCabecera = [border: Color.BLACK, bg: new Color(220, 220, 220), align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, bordeBot: "1"]

        Font times12bold = new Font(Font.TIMES_ROMAN, 12, Font.BOLD)
        Font times14bold = new Font(Font.TIMES_ROMAN, 14, Font.BOLD)
        Font times10bold = new Font(Font.TIMES_ROMAN, 10, Font.BOLD)
        Font times10normal = new Font(Font.TIMES_ROMAN, 10, Font.NORMAL)
        Font times8bold = new Font(Font.TIMES_ROMAN, 8, Font.BOLD)
        Font times8normal = new Font(Font.TIMES_ROMAN, 8, Font.NORMAL)
        Font times7bold = new Font(Font.TIMES_ROMAN, 7, Font.BOLD)
        Font times7normal = new Font(Font.TIMES_ROMAN, 7, Font.NORMAL)
        Font times10boldWhite = new Font(Font.TIMES_ROMAN, 10, Font.BOLD);
        Font times8boldWhite = new Font(Font.TIMES_ROMAN, 8, Font.BOLD)

        times8boldWhite.setColor(Color.WHITE)
        times10boldWhite.setColor(Color.WHITE)

        def fonts = [times12bold     : times12bold, times10bold: times10bold, times8bold: times8bold,
                     times10boldWhite: times10boldWhite, times8boldWhite: times8boldWhite, times8normal: times8normal, times10normal: times10normal]

        def baos = new ByteArrayOutputStream()
        def name = "reporteDiferencia_" + new Date().format("ddMMyyyy_hhmm") + ".pdf";
        def logoPath = servletContext.getRealPath("/") + "images/logos/${empresa?.id}/logo_reportes.png"
        Image logo = Image.getInstance(logoPath);
        logo.scalePercent(70)
        logo.setAlignment(Image.MIDDLE | Image.TEXTWRAP)

        Document document
//        document = new Document(PageSize.A4.rotate());
        document = new Document(PageSize.A4);

        document.setMargins(40, 40, 20, 25);
        def pdfw = PdfWriter.getInstance(document, baos);
        document.open();
        document.addTitle("Direfencias " + new Date().format("dd_MM_yyyy"));
        document.addSubject("Generado por el sistema Obras");
        document.addKeywords("documentosObra, obras, diferencias");
        document.addAuthor("OBRAS");
        document.addCreator("Tedein SA");

        Paragraph headers = new Paragraph();
        headers.setAlignment(Element.ALIGN_CENTER);
        headers.add(new Paragraph(empresa?.nombre?.toUpperCase(), times12bold));
        headers.add(new Paragraph(" ", times10bold));
        headers.add(new Paragraph(empresa?.direccion, times10bold));
        headers.add(new Paragraph("Teléfono: " + (empresa?.telefono ? empresa?.telefono : ''), times10bold));
        headers.add(new Paragraph("Email: " + (empresa?.email ? empresa?.email : ''), times10bold));
        headers.add(new Paragraph(" ", times10bold));
        headers.add(new Paragraph(empresa?.lugar + " -  Ecuador", times10bold));
        headers.add(new Paragraph(" ", times10bold));

        Paragraph headersRemi = new Paragraph();
        headersRemi.setAlignment(Element.ALIGN_CENTER);
        headersRemi.add(new Paragraph("OBRA: " + obra?.nombre, times10bold));
        headersRemi.add(new Paragraph("DIFERENCIAS: COMPOSICIÓN - COSTO", times10bold));
        headersRemi.add(new Paragraph(" ", times10bold));

        //COMPOSICION
        PdfPTable tablaEquipos = new PdfPTable(8);
        tablaEquipos.setWidthPercentage(100);
        tablaEquipos.setWidths(arregloEnteros([12, 32, 8, 10, 10, 10, 10, 8]))

        reportesPdfService.addCellTb(tablaEquipos, new Paragraph("CÓDIGO", times7bold), celdaCabecera)
        reportesPdfService.addCellTb(tablaEquipos, new Paragraph("ITEM", times7bold), celdaCabecera)
        reportesPdfService.addCellTb(tablaEquipos, new Paragraph("UNIDAD", times7bold), celdaCabecera)
        reportesPdfService.addCellTb(tablaEquipos, new Paragraph("COMP. CANT.", times7bold), celdaCabecera)
        reportesPdfService.addCellTb(tablaEquipos, new Paragraph("REQUI. CANT", times7bold), celdaCabecera)
        reportesPdfService.addCellTb(tablaEquipos, new Paragraph("REQUI. PRECIO", times7bold), celdaCabecera)
        reportesPdfService.addCellTb(tablaEquipos, new Paragraph("VALOR", times7bold), celdaCabecera)
        reportesPdfService.addCellTb(tablaEquipos, new Paragraph("DIF.", times7bold), celdaCabecera)

        datos.eachWithIndex { r, i ->
            if (r?.cnsmcntd) {
                reportesPdfService.addCellTb(tablaEquipos, new Paragraph(r?.itemcdgo, times8normal), prmsFilaIzquierda)
                reportesPdfService.addCellTb(tablaEquipos, new Paragraph(r?.itemnmbr, times8normal), prmsFilaIzquierda)
                reportesPdfService.addCellTb(tablaEquipos, new Paragraph(r?.unddcdgo, times8normal), prmsFila)
                reportesPdfService.addCellTb(tablaEquipos, new Paragraph(numero(r?.compcntd, 3)?.toString(), times8normal), prmsFilaDerecha)
                reportesPdfService.addCellTb(tablaEquipos, new Paragraph(numero(r?.cnsmcntd, 3)?.toString(), times8normal), prmsFilaDerecha)
                reportesPdfService.addCellTb(tablaEquipos, new Paragraph(numero(r?.cnsmpcun, 4)?.toString(), times8normal), prmsFilaDerecha)
                reportesPdfService.addCellTb(tablaEquipos, new Paragraph(numero(r?.cnsmvlor, 4)?.toString(), times8normal), prmsFilaDerecha)
                reportesPdfService.addCellTb(tablaEquipos, new Paragraph(numero(r?.cnsmcntd ? (r?.cnsmcntd - r?.compcntd) : 0, 3)?.toString(), times8normal), prmsFilaDerecha)
            }
        }

        PdfPTable tablaHeader = new PdfPTable(2);
        tablaHeader.setWidthPercentage(100);
        tablaHeader.setWidths(arregloEnteros([50, 50]))

        addCellTabla(tablaHeader, logo, prmsCellLeft)
        addCellTabla(tablaHeader, headers, prmsCellCenter)

        document.add(tablaHeader)
        document.add(headersRemi)
        document.add(tablaEquipos)

        document.close();
        pdfw.close()
        byte[] b = baos.toByteArray();
        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + name)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }



    def reporteComposicion() {
        println("params " + params)

        def usuario = Persona.get(session.usuario.id)
        def empresa = usuario.empresa
        def obra = Obra.get(params.obra)

        def sql = "select * from rp_consumo(${params.obra.toInteger()})"
        def cn = dbConnectionService.getConnection()
        def datos = cn.rows(sql)

        println("sql " + sql)

        def prmsHeaderHoja = [border: Color.WHITE]
        def prmsFila = [border: Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
        def prmsFilaIzquierda = [border: Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE]
        def prmsFilaDerecha = [border: Color.WHITE, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE]
        def prmsHeaderHoja2 = [border: Color.WHITE, colspan: 9]
        def prmsHeader = [border: Color.WHITE, colspan: 7, bg: new Color(73, 175, 205),
                          align : Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
        def prmsHeader2 = [border: Color.WHITE, colspan: 3, bg: new Color(73, 175, 205),
                           align : Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
        def prmsCellHead = [border: Color.WHITE, bg: new Color(73, 175, 205),
                            align : Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
        def prmsCellCenter = [border: Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
        def prmsCellRight = [border: Color.BLACK, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE]
        def prmsCellLeft = [border: Color.WHITE, valign: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE]
        def prmsSubtotal = [border: Color.BLACK, colspan: 6,
                            align : Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE]
        def prmsNum = [border: Color.BLACK, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE]
        def prmsCellIzquierda = [border: Color.WHITE,
                                 align : Element.ALIGN_LEFT, valign: Element.ALIGN_LEFT]

        def celdaCabecera = [border: Color.BLACK, bg: new Color(220, 220, 220), align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, bordeBot: "1"]

        Font times12bold = new Font(Font.TIMES_ROMAN, 12, Font.BOLD)
        Font times14bold = new Font(Font.TIMES_ROMAN, 14, Font.BOLD)
        Font times10bold = new Font(Font.TIMES_ROMAN, 10, Font.BOLD)
        Font times10normal = new Font(Font.TIMES_ROMAN, 10, Font.NORMAL)
        Font times8bold = new Font(Font.TIMES_ROMAN, 8, Font.BOLD)
        Font times8normal = new Font(Font.TIMES_ROMAN, 8, Font.NORMAL)
        Font times7bold = new Font(Font.TIMES_ROMAN, 7, Font.BOLD)
        Font times7normal = new Font(Font.TIMES_ROMAN, 7, Font.NORMAL)
        Font times10boldWhite = new Font(Font.TIMES_ROMAN, 10, Font.BOLD);
        Font times8boldWhite = new Font(Font.TIMES_ROMAN, 8, Font.BOLD)

        times8boldWhite.setColor(Color.WHITE)
        times10boldWhite.setColor(Color.WHITE)

        def fonts = [times12bold     : times12bold, times10bold: times10bold, times8bold: times8bold,
                     times10boldWhite: times10boldWhite, times8boldWhite: times8boldWhite, times8normal: times8normal, times10normal: times10normal]

        def baos = new ByteArrayOutputStream()
        def name = "reporteComposicion_" + new Date().format("ddMMyyyy_hhmm") + ".pdf";
        def logoPath = servletContext.getRealPath("/") + "images/logos/${empresa?.id}/logo_reportes.png"
        Image logo = Image.getInstance(logoPath);
        logo.scalePercent(70)
        logo.setAlignment(Image.MIDDLE | Image.TEXTWRAP)

        Document document
//        document = new Document(PageSize.A4.rotate());
        document = new Document(PageSize.A4);

        document.setMargins(40, 40, 20, 25);
        def pdfw = PdfWriter.getInstance(document, baos);
        document.open();
        document.addTitle("Composicion " + new Date().format("dd_MM_yyyy"));
        document.addSubject("Generado por el sistema Obras");
        document.addKeywords("documentosObra, obras, composicion");
        document.addAuthor("OBRAS");
        document.addCreator("Tedein SA");

        Paragraph headers = new Paragraph();
        headers.setAlignment(Element.ALIGN_CENTER);
        headers.add(new Paragraph(empresa?.nombre?.toUpperCase(), times12bold));
        headers.add(new Paragraph(" ", times10bold));
        headers.add(new Paragraph(empresa?.direccion, times10bold));
        headers.add(new Paragraph("Teléfono: " + (empresa?.telefono ? empresa?.telefono : ''), times10bold));
        headers.add(new Paragraph("Email: " + (empresa?.email ? empresa?.email : ''), times10bold));
        headers.add(new Paragraph(" ", times10bold));
        headers.add(new Paragraph(empresa?.lugar + " -  Ecuador", times10bold));
        headers.add(new Paragraph(" ", times10bold));

        Paragraph headersRemi = new Paragraph();
        headersRemi.setAlignment(Element.ALIGN_CENTER);
        headersRemi.add(new Paragraph("OBRA: " + obra?.nombre, times10bold));
        headersRemi.add(new Paragraph("COMPOSICION", times10bold));
        headersRemi.add(new Paragraph(" ", times10bold));

        //COMPOSICION
        PdfPTable tabla1 = new PdfPTable(6);
        tabla1.setWidthPercentage(100);
        tabla1.setWidths(arregloEnteros([12, 50, 8, 10, 10, 10]))

        reportesPdfService.addCellTb(tabla1, new Paragraph("CÓDIGO", times7bold), celdaCabecera)
        reportesPdfService.addCellTb(tabla1, new Paragraph("ITEM", times7bold), celdaCabecera)
        reportesPdfService.addCellTb(tabla1, new Paragraph("UNIDAD", times7bold), celdaCabecera)
        reportesPdfService.addCellTb(tabla1, new Paragraph("COMP. CANT.", times7bold), celdaCabecera)
        reportesPdfService.addCellTb(tabla1, new Paragraph("COMP. PRECIO", times7bold), celdaCabecera)
        reportesPdfService.addCellTb(tabla1, new Paragraph("VALOR", times7bold), celdaCabecera)


        PdfPTable tablaTituloMat = new PdfPTable(2)
        tablaTituloMat.setWidthPercentage(100)
        tablaTituloMat.setWidths(arregloEnteros([90, 10]))
        addCellTabla(tablaTituloMat, new Paragraph("Materiales ", times14bold), prmsCellIzquierda)
        addCellTabla(tablaTituloMat, new Paragraph(" ", times10bold), prmsCellIzquierda)

        PdfPTable tablaMat = new PdfPTable(6);
        tablaMat.setWidthPercentage(100);
        tablaMat.setWidths(arregloEnteros([12, 50, 8, 10, 10, 10]))

        datos.eachWithIndex { r, i ->
            if(r?.compcntd){
                if(r?.grpo__id == 1){
                    reportesPdfService.addCellTb(tablaMat, new Paragraph(r?.itemcdgo, times8normal), prmsFilaIzquierda)
                    reportesPdfService.addCellTb(tablaMat, new Paragraph(r?.itemnmbr, times8normal), prmsFilaIzquierda)
                    reportesPdfService.addCellTb(tablaMat, new Paragraph(r?.unddcdgo, times8normal), prmsFila)
                    reportesPdfService.addCellTb(tablaMat, new Paragraph(numero(r?.compcntd, 3)?.toString(), times8normal), prmsFilaDerecha)
                    reportesPdfService.addCellTb(tablaMat, new Paragraph(numero(r?.compprco, 4)?.toString(), times8normal), prmsFilaDerecha)
                    reportesPdfService.addCellTb(tablaMat, new Paragraph(numero((r?.compprco * r?.compcntd) , 4)?.toString(), times8normal), prmsFilaDerecha)
                }
            }
        }

        PdfPTable tablaTituloM = new PdfPTable(2)
        tablaTituloM.setWidthPercentage(100)
        tablaTituloM.setWidths(arregloEnteros([90, 10]))
        addCellTabla(tablaTituloM, new Paragraph("Mano de Obra ", times14bold), prmsCellIzquierda)
        addCellTabla(tablaTituloM, new Paragraph(" ", times10bold), prmsCellIzquierda)

        PdfPTable tablaMano = new PdfPTable(6);
        tablaMano.setWidthPercentage(100);
        tablaMano.setWidths(arregloEnteros([12, 50, 8, 10, 10, 10]))

        datos.eachWithIndex { r, i ->
            if(r?.compcntd){
                if(r?.grpo__id == 2){
                    reportesPdfService.addCellTb(tablaMano, new Paragraph(r?.itemcdgo, times8normal), prmsFilaIzquierda)
                    reportesPdfService.addCellTb(tablaMano, new Paragraph(r?.itemnmbr, times8normal), prmsFilaIzquierda)
                    reportesPdfService.addCellTb(tablaMano, new Paragraph(r?.unddcdgo, times8normal), prmsFila)
                    reportesPdfService.addCellTb(tablaMano, new Paragraph(numero(r?.compcntd, 3)?.toString(), times8normal), prmsFilaDerecha)
                    reportesPdfService.addCellTb(tablaMano, new Paragraph(numero(r?.compprco, 4)?.toString(), times8normal), prmsFilaDerecha)
                    reportesPdfService.addCellTb(tablaMano, new Paragraph(numero((r?.compprco * r?.compcntd) , 4)?.toString(), times8normal), prmsFilaDerecha)
                }
            }
        }

        PdfPTable tablaTituloE = new PdfPTable(2)
        tablaTituloE.setWidthPercentage(100)
        tablaTituloE.setWidths(arregloEnteros([90, 10]))
        addCellTabla(tablaTituloE, new Paragraph("Equipos ", times14bold), prmsCellIzquierda)
        addCellTabla(tablaTituloE, new Paragraph(" ", times10bold), prmsCellIzquierda)

        PdfPTable tablaEquipos = new PdfPTable(6);
        tablaEquipos.setWidthPercentage(100);
        tablaEquipos.setWidths(arregloEnteros([12, 50, 8, 10, 10, 10]))

        datos.eachWithIndex { r, i ->
            if(r?.compcntd){
                if(r?.grpo__id == 3){
                    reportesPdfService.addCellTb(tablaEquipos, new Paragraph(r?.itemcdgo, times8normal), prmsFilaIzquierda)
                    reportesPdfService.addCellTb(tablaEquipos, new Paragraph(r?.itemnmbr, times8normal), prmsFilaIzquierda)
                    reportesPdfService.addCellTb(tablaEquipos, new Paragraph(r?.unddcdgo, times8normal), prmsFila)
                    reportesPdfService.addCellTb(tablaEquipos, new Paragraph(numero(r?.compcntd, 3)?.toString(), times8normal), prmsFilaDerecha)
                    reportesPdfService.addCellTb(tablaEquipos, new Paragraph(numero(r?.compprco, 4)?.toString(), times8normal), prmsFilaDerecha)
                    reportesPdfService.addCellTb(tablaEquipos, new Paragraph(numero((r?.compprco * r?.compcntd) , 4)?.toString(), times8normal), prmsFilaDerecha)
                }
            }
        }

        PdfPTable tablaHeader = new PdfPTable(2);
        tablaHeader.setWidthPercentage(100);
        tablaHeader.setWidths(arregloEnteros([50, 50]))

        addCellTabla(tablaHeader, logo, prmsCellLeft)
        addCellTabla(tablaHeader, headers, prmsCellCenter)

        document.add(tablaHeader)
        document.add(headersRemi)
        document.add(tabla1)
        document.add(tablaTituloMat)
        document.add(tablaMat)
        document.add(tablaTituloM)
        document.add(tablaMano)
        document.add(tablaTituloE)
        document.add(tablaEquipos)

        document.close();
        pdfw.close()
        byte[] b = baos.toByteArray();
        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + name)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }







}


