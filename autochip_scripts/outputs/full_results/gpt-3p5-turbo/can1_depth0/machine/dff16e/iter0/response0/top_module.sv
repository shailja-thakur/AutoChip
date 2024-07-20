module top_module(
	input clk,
	input resetn,
	input [1:0] byteena,
	input [15:0] d,
	output reg [15:0] q);

	// Registers
	reg [15:0] register;

	// Always block triggered by the rising edge of clk
	always @(posedge clk) begin
		
		// Reset the register when resetn is low
		if (!resetn) begin
			register <= 16'h0000;
		end
		// Write data to the register based on byteena
		else begin
			if (byteena[0]) begin
				register[7:0] <= d[7:0];
			end
			if (byteena[1]) begin
				register[15:8] <= d[15:8];
			end
		end
	end

	// Assign the value of the register to the output q
	assign q = register;

endmodule
