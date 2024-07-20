module top_module (
  input clk,
  input a,
  output reg [2:0] q
);

  always @(posedge clk) begin
    if (a == 1'b1 && q != 3'b100) begin
      if (q == 3'b000)
        q <= 3'b100;
      else
        q <= q + 1;
    end else begin
      q <= 3'b000;
    end
  end

endmodule
