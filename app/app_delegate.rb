class AppDelegate
  TOOLBAR_IDENTIFIER = "AppToolbar"

  def applicationDidFinishLaunching(notification)
    buildMenu
    buildWindow
  end

  def buildWindow
    @mainWindow = NSWindow.alloc.initWithContentRect([[240, 180], [480, 360]],
      styleMask: NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false)
    @mainWindow.title = NSBundle.mainBundle.infoDictionary['CFBundleName']
    @mainWindow.orderFrontRegardless

    @layout = MainLayout.new
    @mainWindow.contentView = @layout.view

    @toolbar = NSToolbar.alloc.initWithIdentifier(TOOLBAR_IDENTIFIER)
    @toolbar.displayMode = NSToolbarDisplayModeLabelOnly
    @toolbar.delegate = self
    @mainWindow.setToolbar(@toolbar)

    @content = @layout.get(:content)

    NSColorPanel.sharedColorPanel.target = self
    NSColorPanel.sharedColorPanel.action = 'color_selected:'
  end

  def toolbarAllowedItemIdentifiers(toolbar)
    [NSToolbarShowColorsItemIdentifier]
  end

  def toolbarDefaultItemIdentifiers(toolbar)
    [NSToolbarShowColorsItemIdentifier]
  end

  def toolbar(toolbar, itemForItemIdentifier: identifier, willBeInsertedIntoToolbar: flag)
    nil
  end

  def color_selected(sender)
    @content.backgroundColor = sender.color
  end
end