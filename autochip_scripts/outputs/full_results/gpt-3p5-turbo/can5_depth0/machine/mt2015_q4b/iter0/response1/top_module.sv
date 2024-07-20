module top_module(
	input x,
	input y,
	output z;
);
  reg z; //Define a register to store the value of z
  
  always @(x, y) begin //Sensitivity list
    z <= ~(x ^ y); //Logic for z
  end
  
endmodule
