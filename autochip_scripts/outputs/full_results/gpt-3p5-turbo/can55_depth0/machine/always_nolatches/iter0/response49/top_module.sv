module top_module (
  input [15:0] scancode,
  output reg left,
  output reg down,
  output reg right,
  output reg up
);
  
  always @(*) begin
    case(scancode)
      16'hE06B: left = 1;
      default: left = 0;
    endcase

    case(scancode)
      16'hE072: down = 1;
      default: down = 0;
    endcase

    case(scancode)
      16'hE074: right = 1;
      default: right = 0;
    endcase

    case(scancode)
      16'hE075: up = 1;
      default: up = 0;
    endcase
  end
endmodule
