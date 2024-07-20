module top_module(
  input clk,
  input reset,
  output reg shift_ena);

  reg [2:0] state;
  reg [7:0] pattern;
  reg [3:0] count;

  parameter IDLE = 0;
  parameter DETECT = 1;
  parameter SHIFT = 2;

  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
      shift_ena <= 0;
      count <= 0;
      pattern <= 8'b10101010;
    end
    else begin
      case (state)
        IDLE: begin
            if (pattern[count] == 1) begin
              state <= DETECT;
              count <= 0;
              shift_ena <= 1;
            end else begin
              count <= count + 1;
            end
          end
          
        DETECT: begin
            if (count == 3) begin
              state <= SHIFT;
              count <= 0;
              shift_ena <= 0;
            end else begin
              count <= count + 1;
            end
          end

        SHIFT: begin
            if (count == 3) begin
              state <= IDLE;
              count <= 0;
              shift_ena <= 0;
            end else begin
              count <= count + 1;
            end
          end
          
        default: state <= IDLE;
      endcase
    end
  end  
endmodule
