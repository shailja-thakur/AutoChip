module top_module (
  input clk,
  input aresetn,
  input x,
  output reg z
);

  reg [1:0] state;  // state variable to represent the current state of the FSM

  always @(negedge aresetn or posedge clk) begin
    if (~aresetn) begin // asynchronous reset
      state <= 2'b00; // reset to initial state
      z <= 1'b0; // reset output signal
    end else begin
      case (state)
        2'b00: // state 0
          if (x) begin
            state <= 2'b01; // transition to state 1 when x is high
          end
        2'b01: // state 1
          if (x) begin
            state <= 2'b10; // transition to state 2 when x is high
          end else begin
            state <= 2'b00; // transition back to state 0 when x is low
          end
        2'b10: // state 2
          if (x) begin
            z <= 1'b1; // output signal is asserted when "101" sequence is detected
            state <= 2'b00; // transition back to state 0 when x is high
          end else begin
            state <= 2'b10; // stay in state 2 when x is low
          end
        default:
          state <= 2'b00; // default to initial state if unexpected state occurs
      endcase
    end
  end

endmodule
