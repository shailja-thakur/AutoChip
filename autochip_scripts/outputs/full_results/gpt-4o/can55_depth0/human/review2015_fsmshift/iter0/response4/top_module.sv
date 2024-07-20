module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [2:0] count;

	always @(posedge clk) begin
		if (reset) begin
			count <= 3'b100; // Initialize the count to 4
		end else if (count != 3'b000) begin
			count <= count - 1;
		end
	end

	always @(posedge clk) begin
		if (reset) begin
			shift_ena <= 1'b1;  // Enable shift_ena during reset
		end else if (count > 3'b000) begin
			shift_ena <= 1'b1;  // Enable shift_ena for 4 cycles
		end else begin
			shift_ena <= 1'b0;  // Disable shift_ena after 4 cycles
		end
	end
endmodule
