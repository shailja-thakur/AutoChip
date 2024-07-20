module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  reg [31:0] next_q;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= 32'h1;
    end else begin
      next_q[31:0] = {q[30:0], q[0] ^ q[20] ^ q[30] ^ q[31]};
      q <= next_q[31:0];
    end
  end

endmodule
