class AppDelegate
  TOOLBAR_IDENTIFIER = "AppToolbar"
  INCREMENT_TOOLBAR_ITEM_IDENTIFIER = "IncrementToolbarItem"
  TAB_VIEW_ITEM_IDENTIFIER = "TabViewItem"

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

    @content_heading = @layout.get(:content_heading)

    NSColorPanel.sharedColorPanel.target = self
    NSColorPanel.sharedColorPanel.action = 'color_selected:'

    @content_tabs = @layout.get(:content_tabs)
    colors = [NSColor.redColor, NSColor.greenColor, NSColor.blueColor]
    [1, 2, 3].each do |number|
      @tab_view_item = NSTabViewItem.alloc.initWithIdentifier("#{TAB_VIEW_ITEM_IDENTIFIER}_#{number}")
      @tab_view_item.label = "test tab #{number}"
      @tab_view_item.view = NSView.alloc.initWithFrame(@content_tabs.contentRect)
      @tab_view_item.view.wantsLayer = true
      @tab_view_item.view.backgroundColor = colors.delete(colors.shuffle.first)
      @content_tabs.addTabViewItem(@tab_view_item)
    end
  end

  def toolbarAllowedItemIdentifiers(toolbar)
    [NSToolbarShowColorsItemIdentifier, INCREMENT_TOOLBAR_ITEM_IDENTIFIER]
  end

  def toolbarDefaultItemIdentifiers(toolbar)
    [NSToolbarShowColorsItemIdentifier, INCREMENT_TOOLBAR_ITEM_IDENTIFIER]
  end

  def toolbar(toolbar, itemForItemIdentifier: identifier, willBeInsertedIntoToolbar: flag)
    if identifier == INCREMENT_TOOLBAR_ITEM_IDENTIFIER
      item = NSToolbarItem.alloc.initWithItemIdentifier(INCREMENT_TOOLBAR_ITEM_IDENTIFIER)
      item.label = "Increment"
      item.toolTip = "Increment our content view counter."
      item.target = self
      item.action = 'increment:'
      item
    else
      nil
    end
  end

  def toolbarWillAddItem(notification)
    toolbar_item = notification.userInfo.objectForKey('item')
    toolbar_item.label = "Choose Content Background Color" if toolbar_item.itemIdentifier == NSToolbarShowColorsItemIdentifier
  end

  def color_selected(sender)
    @content.backgroundColor = sender.color
  end

  def increment(toolbar)
    @content_counter ||= 0
    @content_counter += 1
    @content_heading.stringValue = "#{@content_counter} times"
  end
end
