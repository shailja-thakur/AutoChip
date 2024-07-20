module top_module(
  input clk,
  input reset,
  output reg [31:0] q
);

  reg [31:0] next_q;

  always @(posedge clk or posedge reset) begin
    if (reset)
      q <= 32'h1;
    else begin
      next_q[31] <= q[22] ^ q[10] ^ q[1] ^ q[0];
      next_q[30:0] <= {q[31:1]};
      q <= next_q;
    end
  end

endmodule
