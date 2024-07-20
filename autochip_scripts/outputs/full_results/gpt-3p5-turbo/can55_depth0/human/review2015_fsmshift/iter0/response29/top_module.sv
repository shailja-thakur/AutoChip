module top_module (
  input clk,
  input reset,
  output reg shift_ena
);
  
  reg [2:0] state;
  reg [7:0] pattern;
  
  parameter IDLE = 0;
  parameter DETECT_PATTERN = 1;
  parameter SHIFT_ENABLE = 2;
  
  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
      shift_ena <= 1'b0;
    end
    else begin
      case (state)
        IDLE:
          begin
            if (pattern == 8'bXXXXXXXX)  // Replace XXXXXXXX with the desired bit pattern
              state <= DETECT_PATTERN;
            else
              state <= IDLE;
          end
          
        DETECT_PATTERN:
          begin
            state <= SHIFT_ENABLE;
          end
          
        SHIFT_ENABLE:
          begin
            if (shift_ena == 4)
              state <= IDLE;
            else
              state <= SHIFT_ENABLE;
          end
      endcase
    end
  end
  
  always @(*) begin
    case (state)
      SHIFT_ENABLE:
        begin
          shift_ena = 1'b1;
        end
        
      default:
        begin
          shift_ena = 1'b0;
        end
    endcase
  end
  
endmodule
