module top_module(
  input clk,
  input slowena,
  input reset,
  output reg [3:0] q
);

  reg [3:0] next_q;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      next_q <= 4'b0000;
    end else if (slowena) begin
      next_q <= q + 1;
    end
  end

  always @(posedge clk) begin
    q <= next_q;
  end

endmodule
