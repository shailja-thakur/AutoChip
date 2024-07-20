module top_module(
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q);

  // Declare 8 D flip-flops
  reg [7:0] q_ff [0:7];

  // Assign outputs
  assign q = q_ff;

  // Synchronous reset process
  always @(posedge clk) begin
    if (reset) begin
      q_ff <= 0;
    end else begin
      q_ff <= d;
    end
  end
endmodule
