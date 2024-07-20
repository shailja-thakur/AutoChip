module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q);

	// Internal wire declaration
	wire [99:0] shifted_data;

	// Register for storing the loaded data
	reg [99:0] data_register;

	// Data loading process
	always @(posedge clk) begin
		if (load)
			data_register <= data;
	end

	// Data shifting process
	always @(posedge clk) begin
		case (ena)
			2'h1: shifted_data <= {data_register[98:0], 1'b0}; // Shift left
			2'h2: shifted_data <= {1'b0, data_register[99:1]}; // Shift right
			default: shifted_data <= data_register; // No shift
		endcase
	end

	// Assign shifted data to output
	always @(posedge clk) begin
		q <= shifted_data;
	end

endmodule
