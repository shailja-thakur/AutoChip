module top_module(
  input clk,
  input reset,
  output reg [31:0] q
);

  reg [31:0] next_q;

  always @(posedge clk or posedge reset) begin
    if (reset)
      next_q <= 32'h1;
    else begin
      next_q <= {q[30:0], q[21] ^ q[1] ^ q[0]};
    end
  end

  always @(posedge clk) begin
    if (reset)
      q <= 32'h1;
    else
      q <= next_q;
  end

endmodule
