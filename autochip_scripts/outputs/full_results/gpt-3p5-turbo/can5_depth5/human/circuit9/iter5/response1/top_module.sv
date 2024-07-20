module top_module (
  input clk,
  input a,
  output reg [2:0] q
);

  reg [2:0] next_q;

  always @(posedge clk) begin
    if (a) begin
      if (q < 7)
        next_q <= q + 1;
      else
        next_q <= 7;
    end else begin
      next_q <= q;
    end
  end

  always @(posedge clk) begin
    q <= next_q;
  end

endmodule
