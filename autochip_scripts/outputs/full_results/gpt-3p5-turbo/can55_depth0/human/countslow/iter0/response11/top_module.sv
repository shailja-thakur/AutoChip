module top_module(
  input clk,
  input slowena,
  input reset,
  output reg [3:0] q);

  reg [3:0] next_q;

  always @(posedge clk) begin
    if (reset) begin
      next_q <= 0;
    end else if (slowena) begin
      if (q <= 9) begin
        next_q <= q + 1;
      end else begin
        next_q <= 0;
      end
    end else begin
      next_q <= q;
    end
  end

  always @(posedge clk) begin
    q <= next_q;
  end

endmodule
