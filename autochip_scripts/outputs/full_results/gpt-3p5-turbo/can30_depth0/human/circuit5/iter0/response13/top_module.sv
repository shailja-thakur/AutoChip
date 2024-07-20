module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

	always @* begin
		// Define the behavior for the combinational circuit
		case ({a,b,c})
			4'b000 : q = b; // When a=0, b=0, c=0, set q to b
			4'b001 : q = e; // When a=0, b=0, c=1, set q to e
			4'b010 : q = a; // When a=0, b=1, c=0, set q to a
			4'b011 : q = d; // When a=0, b=1, c=1, set q to d
			4'b100 : q = f; // When a=1, b=0, c=0, set q to f
			4'b101 : q = f; // When a=1, b=0, c=1, set q to f
			4'b110 : q = f; // When a=1, b=1, c=0, set q to f
			4'b111 : q = f; // When a=1, b=1, c=1, set q to f
		endcase
	end

endmodule
