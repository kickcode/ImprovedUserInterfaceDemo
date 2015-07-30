class MainLayout < MotionKit::Layout
  SIDEBAR_WIDTH = 150
  TAB_VIEW_ITEM_IDENTIFIER = "TabViewItem"

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

      add NSTextField, :sidebar_heading do
        bezeled false
        drawsBackground false
        editable false
        selectable false
        stringValue "Sidebar"
        constraints do
          width.equals(:superview).minus(20)

          min_left.is 10
          min_top.is 10
        end
      end

      add Motion::Meter::ThresholdMeter, :sidebar_meter do
        min_value 0
        max_value 100
        value 50

        add_threshold 0, 33, NSColor.redColor
        add_threshold 33, 66, NSColor.yellowColor
        add_threshold 66, 100, NSColor.greenColor

        constraints do
          width.equals(:superview).minus(20)
          height.is 30

          min_left.is 10
          min_top.equals(:sidebar_heading).plus(20)
        end
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

      add NSTextField, :content_heading do
        bezeled false
        drawsBackground false
        editable false
        selectable false
        stringValue "Content"
        constraints do
          width.equals(:superview).minus(20)

          min_left.is 10
          min_top.is 10
        end
      end

      add NSTabView, :content_tabs do
        constraints do
          width.equals(:superview)
          height.equals(:superview).minus(30)
        end

        colors = [NSColor.redColor, NSColor.greenColor, NSColor.blueColor]
        [1, 2, 3].each do |number|
          add_tab "#{TAB_VIEW_ITEM_IDENTIFIER}_#{number}", "test tab #{number}" do
            wantsLayer true
            backgroundColor colors.delete(colors.shuffle.first)

            add GradientView, :"gradient_#{number}" do
              constraints do
                width.equals(:superview)
                height.equals(:superview)
              end

              add NSTextField, :"tab_view_item_#{number}_label" do
                bezeled false
                drawsBackground false
                editable false
                selectable false
                stringValue "Tab Number #{number}"

                constraints do
                  width.equals(:superview)
                  height.is(30)

                  min_left.is 10
                  min_top.is 10
                end
              end
            end
          end
        end
      end
    end
  end
end
