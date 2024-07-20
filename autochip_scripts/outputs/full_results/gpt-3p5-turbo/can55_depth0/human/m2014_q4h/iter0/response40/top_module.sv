module top_module(
	input in,
	output reg out); // Added 'reg' keyword for the output port

	always @(*) // Combinational logic
	begin
		out = in; // Assign input port to output port
	end
	
endmodule
