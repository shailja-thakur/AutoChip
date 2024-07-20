module top_module(
  input clk,
  input reset,
  output reg shift_ena);

  reg [3:0] count;

  // FSM states
  localparam IDLE = 2'b00;
  localparam DETECTED = 2'b01;
  localparam ENABLED = 2'b10;

  reg [1:0] state;

  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
      count <= 0;
      shift_ena <= 0;
    end else begin
      case(state)
        IDLE: begin
          if (detect_pattern()) begin
            state <= DETECTED;
          end
          count <= 0;
          shift_ena <= 0;
        end

        DETECTED: begin
          if (count == 3) begin
            state <= ENABLED;
          end else begin
            count <= count + 1;
          end
          shift_ena <= 1;
        end

        ENABLED: begin
          if (count == 0) begin
            state <= IDLE;
          end else begin
            count <= count - 1;
          end
          shift_ena <= 0;
        end

        default: state <= IDLE;
      endcase
    end
  end

  function detect_pattern;
    // Insert detection logic here
    // Return 1 if pattern is detected, otherwise 0
  endfunction

endmodule
