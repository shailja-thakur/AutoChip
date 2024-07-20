module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  reg [31:0] next_q;

  always @(posedge clk) begin
    if (reset) begin
      q <= 32'b1;
      next_q <= 32'b1;
    end
    else begin
      next_q[31] <= q[21] ^ q[1] ^ q[0];
      next_q[30:0] <= q[29:0];
      q <= next_q;
    end
  end

endmodule
