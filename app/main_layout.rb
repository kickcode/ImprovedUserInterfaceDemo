class MainLayout < MotionKit::Layout
  SIDEBAR_WIDTH = 150

  def layout
    add NSView, :sidebar do
      wantsLayer true
      backgroundColor NSColor.lightGrayColor
      constraints do
        height.equals(:superview)
        width.is SIDEBAR_WIDTH

        min_left.is 0
        min_top.is 0
      end
    end
    add NSView, :content do
      wantsLayer true
      backgroundColor NSColor.grayColor
      constraints do
        height.equals(:superview)
        width.equals(:superview).minus(SIDEBAR_WIDTH)

        min_left.is SIDEBAR_WIDTH
        min_top.is 0
      end
    end
  end
end