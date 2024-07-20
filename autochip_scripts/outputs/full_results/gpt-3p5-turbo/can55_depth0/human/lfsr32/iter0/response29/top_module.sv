module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= 32'h1;
    else begin
      q <= {q[21:0], q[2] ^ q[21] ^ q[31]}; // feedback arrangement
    end
  end
endmodule
