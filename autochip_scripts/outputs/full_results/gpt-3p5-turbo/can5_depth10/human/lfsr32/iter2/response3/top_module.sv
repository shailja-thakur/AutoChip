module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= 32'h1;
    end else begin
      q <= {q[30:0], q[31] ^ q[21] ^ q[1] ^ q[0]};
    end
  end

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

endmodule
