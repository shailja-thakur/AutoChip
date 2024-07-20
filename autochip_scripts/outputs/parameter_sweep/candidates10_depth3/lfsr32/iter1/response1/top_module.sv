module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  reg [31:0] next_q;

  always @(posedge clk) begin
    if (reset)
      next_q <= 32'b1;
    else begin
      next_q <= {q[30:0]^q[20]^q[0], q[31:1]};
    end
  end

  always @(posedge clk) begin
    if (reset)
      q <= 32'b1;
    else
      q <= next_q;
  end

endmodule
