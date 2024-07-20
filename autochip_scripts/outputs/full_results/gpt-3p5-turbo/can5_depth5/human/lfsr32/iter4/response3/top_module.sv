module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= 32'h1;
    end else begin
      q <= {q[31:1], q[21]^q[1]^q[0]};
    end
  end

endmodule
