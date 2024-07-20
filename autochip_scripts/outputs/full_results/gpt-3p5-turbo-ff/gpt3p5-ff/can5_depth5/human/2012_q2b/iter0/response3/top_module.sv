module top_module (
  input [5:0] y,
  input w,
  output Y1,
  output Y3
);

  reg Y1_reg, Y3_reg;

  always @(posedge w or posedge y[0]) begin
    if (y[1])
      Y1_reg <= 1'b1;
    else
      Y1_reg <= 1'b0;
    
    if (y[3])
      Y3_reg <= 1'b1;
    else
      Y3_reg <= 1'b0;
  end

  assign Y1 = Y1_reg;
  assign Y3 = Y3_reg;

endmodule
