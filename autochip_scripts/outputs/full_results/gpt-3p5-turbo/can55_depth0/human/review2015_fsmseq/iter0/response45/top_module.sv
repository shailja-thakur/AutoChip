module top_module(
  input clk,
  input reset,
  input data,
  output start_shifting);

  reg [3:0] state; // define state register
  reg start_shifting; // define start_shifting register

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0; // reset state
      start_shifting <= 0; // reset start_shifting
    end else begin
      case (state)
        0: if (data) state <= 1; // look for rising edge
        1: if (data) state <= 2; else state <= 0; // look for 2nd rising edge
        2: if (data) state <= 3; else state <= 0; // look for falling edge
        3: if (data) begin
             state <= 4; // look for falling edge
             start_shifting <= 1; // sequence found, set start_shifting
           end else state <= 0; // sequence not found, reset state
        4: if (data) state <= 4; else state <= 0; // stay in state 4 until reset
        default: state <= 0; // default case for reset condition
      endcase
    end
  end

endmodule
