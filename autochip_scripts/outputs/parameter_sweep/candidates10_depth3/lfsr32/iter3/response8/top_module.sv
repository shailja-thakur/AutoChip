module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  reg [31:0] next_q;

  always @(posedge clk or posedge reset) begin
    if (reset)
      next_q <= 32'b1;
    else begin
      next_q <= {next_q[31]^next_q[21]^next_q[1]^next_q[0], next_q[31:1]};
    end
  end

  always @(posedge clk) begin
    if (reset)
      q <= 32'b1;
    else
      q <= next_q;
  end

endmodule
