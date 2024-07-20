module top_module (
  input clk,
  input d,
  input ar,
  output logic q
);

  always @(posedge clk or posedge ar) begin
    if(ar == 1'b1) begin
      q <= 1'b0;
    end
    else begin
      q <= d;
    end
  end

endmodule
