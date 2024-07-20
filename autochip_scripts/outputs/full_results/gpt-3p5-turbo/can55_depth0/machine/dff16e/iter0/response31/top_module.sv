module top_module(
	input clk,
	input resetn,
	input [1:0] byteena,
	input [15:0] d,
	output reg [15:0] q);
	
	// Register for storing data
	reg [15:0] register;
	
	// Synchronous reset
	always @(posedge clk, negedge resetn)
	begin
		if (!resetn)
			register <= 16'b0;
		else
		begin
			// Write data based on the byte enable signal
			if (byteena[0])
				register[7:0] <= d[7:0];
			if (byteena[1])
				register[15:8] <= d[15:8];
		end
	end
	
	// Assign the output
	assign q = register;
	
endmodule
