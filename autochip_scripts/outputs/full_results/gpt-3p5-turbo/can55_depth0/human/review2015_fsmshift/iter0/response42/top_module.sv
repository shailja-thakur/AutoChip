module top_module(
  input clk,
  input reset,
  output reg shift_ena);

  reg [2:0] state;
  reg [3:0] counter;

  parameter IDLE = 2'b00;
  parameter DETECT = 2'b01;
  parameter ENABLE = 2'b10;

  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
      counter <= 0;
    end else begin
      case (state)
        IDLE:
          if (shift_ena_pattern_detected()) begin
            state <= DETECT;
            counter <= 0;
          end
        DETECT:
          if (counter < 4) begin
            state <= DETECT;
            counter <= counter + 1;
            shift_ena <= 1;
          end else begin
            state <= ENABLE;
            counter <= 0;
            shift_ena <= 0;
          end
        ENABLE:
          state <= IDLE;
          counter <= 0;
      endcase
    end
  end

  function shift_ena_pattern_detected;
    input [7:0] shift_reg_data;
    begin
      // Replace 'shift_reg_data' with the proper expression to detect the desired bit pattern
      shift_ena_pattern_detected = (shift_reg_data == 8'b11001100);
    end
  endfunction
  
endmodule
