module top_module(
  input clk,
  input [7:0] d,
  output reg [7:0] q
);
  
  reg [7:0] q_next; // Next state of the output register

  always @(posedge clk) begin // Executed on the positive edge of the clock
    q_next <= d; // Update the next state of the output register with the input data
  end

  always @(posedge clk) begin // Executed on the positive edge of the clock
    q <= q_next; // Update the output register with the next state
  end

endmodule
