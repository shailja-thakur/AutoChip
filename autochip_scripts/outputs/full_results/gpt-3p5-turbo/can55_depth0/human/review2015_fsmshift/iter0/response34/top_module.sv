module top_module(
  input clk,
  input reset,
  output shift_ena);

  reg [2:0] state;
  reg [3:0] counter;

  parameter IDLE_STATE = 0;
  parameter ENABLE_STATE = 1;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE_STATE;
      counter <= 0;
    end else begin
      case(state)
        IDLE_STATE: begin
          counter <= 0;
          if (bit_pattern_detected()) begin
            state <= ENABLE_STATE;
            shift_ena <= 1;
          end
        end
        ENABLE_STATE: begin
          counter <= counter + 1;
          if (counter == 3) begin
            state <= IDLE_STATE;
            shift_ena <= 0;
          end
        end
      endcase
    end
  end

  function bit_pattern_detected;
  begin
    // Implementation of bit pattern detection logic goes here
    // Return 1 if bit pattern detected, 0 otherwise
  end
  endfunction

endmodule
