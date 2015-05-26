class MainLayout < MotionKit::Layout
  SIDEBAR_WIDTH = 150

  def layout
    add NSBox, :sidebar do
      title "Sidebar"
      constraints do
        height.equals(:superview)
        width.is SIDEBAR_WIDTH

        min_left.is 0
        min_top.is 0
      end
    end
    add NSBox, :content do
      title "Content"
      constraints do
        height.equals(:superview)
        width.equals(:superview).minus(SIDEBAR_WIDTH + 10)

        min_right.is 0
        min_top.is 0
      end
    end
  end
end