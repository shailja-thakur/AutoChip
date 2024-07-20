module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  always @(posedge clk or posedge reset) begin
    if (reset)
      q <= 32'b1;
    else
      q <= {q[30]^q[20]^q[0]^q[31], q[31:1]};
  end

endmodule
