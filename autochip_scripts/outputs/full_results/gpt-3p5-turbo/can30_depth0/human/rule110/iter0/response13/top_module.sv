module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	// Define internal wire for boundary conditions
	wire [512:0] q_wired;

	// Assign boundary conditions to the internal wire
	assign q_wired[0] = 0;
	assign q_wired[513] = 0;
	
	// Register for storing the loaded data
	reg [511:0] loaded_data;

	// Load data into the register when load signal is high
	always @(posedge clk) begin
		if (load) begin
			loaded_data <= data;
		end
	end

	// Apply Rule 110 logic to update the cells each clock cycle
	always @(posedge clk) begin
		for (integer i = 0; i < 512; i = i + 1) begin
			if (i == 0) begin
				q_wired[i + 1] <= loaded_data[i] & loaded_data[i] & loaded_data[i + 1];
			end else if (i == 511) begin
				q_wired[i] <= loaded_data[i - 1] & loaded_data[i] & 0;
			end else begin
				q_wired[i + 1] <= loaded_data[i] & loaded_data[i] & loaded_data[i + 1];
				q_wired[i] <= loaded_data[i - 1] & loaded_data[i] & loaded_data[i + 1];
			end
		end
	end

	// Assign the values from the internal wire to the output q
	always @(posedge clk) begin
		q <= q_wired[1:512];
	end

endmodule
