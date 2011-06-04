require "junodoc/version"
require 'java'

$CLASSPATH << '/Applications/OpenOffice.org.app/Contents/MacOS/'
$CLASSPATH << '/Applications/OpenOffice.org.app/Contents/basis-link/ure-link/share/java'
$CLASSPATH << '/Applications/OpenOffice.org.app/Contents/basis-link/program/classes'

require 'java_uno.jar'
require 'juh.jar'
require 'jurt.jar'
require 'ridl.jar'
require 'unoloader.jar'
require 'unoil.jar'

module JunoDoc
  class Document
    attr_accessor :name

    def initialize
      @context = create_context
      @doc = open_writer(@context)

      @document_text = @doc.getText
      @cursor = @document_text.createTextCursor
    end

    def add_text(text)
      @document_text.insertString(@cursor, text, false )
    end

    def add_image(image_url)
       xMSFDoc = com::sun::star::uno::UnoRuntime.queryInterface(com::sun::star::lang::XMultiServiceFactory.java_class, @doc)
      oGraphic = xMSFDoc.createInstance("com.sun.star.text.TextGraphicObject")

      xPropSet = com::sun::star::uno::UnoRuntime.queryInterface(com::sun::star::beans::XPropertySet.java_class, oGraphic)
      xPropSet.setPropertyValue("GraphicURL", image_url)

      xTextContent = com::sun::star::uno::UnoRuntime.queryInterface(com::sun::star::text::XTextContent.java_class, oGraphic)
      @document_text.insertTextContent(@cursor, xTextContent, true);
    end

    def add_paragraph_break
      @document_text.insertControlCharacter(@cursor, com::sun::star::text::ControlCharacter.PARAGRAPH_BREAK, false)
    end

    def create_context
      com::sun::star::comp::helper::Bootstrap.bootstrap()
    end

    def open_writer(context)
      xMCF = context.getServiceManager();
      oDesktop = xMCF.createInstanceWithContext("com.sun.star.frame.Desktop", context);
      xCLoader = com::sun::star::uno::UnoRuntime.queryInterface(com::sun::star::frame::XComponentLoader.java_class, oDesktop);
      # This is creating a new java array
      szEmptyArgs = Java::com.sun.star.beans.PropertyValue[0].new
      xComp = xCLoader.loadComponentFromURL("private:factory/swriter", "_blank", 0, szEmptyArgs);
      xDoc = com::sun::star::uno::UnoRuntime.queryInterface(com::sun::star::text::XTextDocument.java_class, xComp);
      return xDoc;
    end
  end
end
