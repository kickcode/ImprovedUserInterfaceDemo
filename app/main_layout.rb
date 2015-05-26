class MainLayout < MotionKit::Layout
  def layout
    add NSBox, :sidebar do
      title "Sidebar"
      constraints do
        height.equals(:superview)
        width.equals(:superview).times(0.3)

        min_left.is 0
        min_top.is 0
      end
    end
    add NSBox, :content do
      title "Content"
      constraints do
        height.equals(:superview)
        width.equals(:superview).times(0.7).minus(10)

        min_right.is 0
        min_top.is 0
      end
    end
  end
end