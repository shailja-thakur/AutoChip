module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  reg [31:0] next_q;

  always @(posedge clk) begin
    if (reset)
      next_q <= 32'b1;
    else begin
      next_q[31] <= next_q[21] ^ next_q[1] ^ next_q[0];
      next_q[30:0] <= q[31:1];
    end
  end

  assign q = next_q;

endmodule
