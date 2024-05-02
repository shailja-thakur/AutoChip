module top_module (
  output reg zero
);

  always @(posedge clk) begin
    zero <= 0;
  end

endmodule