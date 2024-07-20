module top_module(
	output reg one); // Added "reg" datatype

  always @(in your sensitivity list) // Sensitivity list should be added here
	begin
	  one = 1'b1; // Assigning output "one" a constant value of 1
	end
  
endmodule
