module top_module(
	output reg one); //missing data type for output "one"
	
	always @(*) begin //missing begin-end block for always statement
		one = 1'b1; //assign value to output "one"
	end
	
endmodule
