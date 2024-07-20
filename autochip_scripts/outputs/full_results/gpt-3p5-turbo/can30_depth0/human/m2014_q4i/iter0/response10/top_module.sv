module top_module(
  output reg out);

  always @(posedge clk) begin
    out <= 1'b0;
  end

endmodule
