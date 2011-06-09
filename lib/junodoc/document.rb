module JunoDoc
  class Document
    attr_accessor :name

    def initialize
      require 'java_uno.jar'
      require 'juh.jar'
      require 'jurt.jar'
      require 'ridl.jar'
      require 'unoloader.jar'
      require 'unoil.jar'

      @context = create_context
      @doc = open_writer
      @stored_document = com::sun::star::uno::UnoRuntime.queryInterface(com::sun::star::frame::XStorable.java_class, @doc)
      @document_text = @doc.getText
      @cursor = @document_text.createTextCursor
    end

    def add_text(text)
      @document_text.insertString(@cursor, text, false)
    end

    def add_image(image_url)
      xMSFDoc = com::sun::star::uno::UnoRuntime.queryInterface(com::sun::star::lang::XMultiServiceFactory.java_class, @doc)
      oGraphic = xMSFDoc.createInstance("com.sun.star.text.TextGraphicObject")

      xPropSet = com::sun::star::uno::UnoRuntime.queryInterface(com::sun::star::beans::XPropertySet.java_class, oGraphic)
      xPropSet.setPropertyValue("GraphicURL", image_url)
      xPropSet.setPropertyValue("Height", 4000.to_java(:int))
      xPropSet.setPropertyValue("Width", 5000.to_java(:int))

      xTextContent = com::sun::star::uno::UnoRuntime.queryInterface(com::sun::star::text::XTextContent.java_class, oGraphic)
      @document_text.insertTextContent(@cursor, xTextContent, true);
    end

    def add_paragraph_break
      @document_text.insertControlCharacter(@cursor, com::sun::star::text::ControlCharacter.PARAGRAPH_BREAK, false)
    end

    def write_document(path)
      propertyValues = Java::com::sun::star::beans::PropertyValue[2].new
      propertyValues[0] = Java::com::sun::star::beans::PropertyValue.new
      propertyValues[0].Name = "Overwrite"
      propertyValues[0].Value = true

      propertyValues[1] = Java::com::sun::star::beans::PropertyValue.new
      propertyValues[1].Name = "FilterName"
      propertyValues[1].Value = "swriter: MS Word 97"

      sStoreUrl = "file://#{path}"
      @stored_document.storeAsURL(sStoreUrl, propertyValues)
    end

    def close_document
      xCloseable = com::sun::star::uno::UnoRuntime.queryInterface(com::sun::star::util::XCloseable.java_class, @stored_document)
      xCloseable.close(false)
    end

    private
    def create_context
      com::sun::star::comp::helper::Bootstrap.bootstrap()
    end

    def open_writer
      xMCF = @context.getServiceManager()
      oDesktop = xMCF.createInstanceWithContext("com.sun.star.frame.Desktop", @context)
      xCLoader = com::sun::star::uno::UnoRuntime.queryInterface(com::sun::star::frame::XComponentLoader.java_class, oDesktop)
      szEmptyArgs = Java::com.sun.star.beans.PropertyValue[0].new
      xComp = xCLoader.loadComponentFromURL("private:factory/swriter", "_blank", 0, szEmptyArgs)
      com::sun::star::uno::UnoRuntime.queryInterface(com::sun::star::text::XTextDocument.java_class, xComp)
    end

  end
end
