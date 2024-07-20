module top_module(
	input wire clk,
	input wire reset,
	output reg shift_ena);

	// Internal signal to count 4 clock cycles
	reg [1:0] count;

	// State declaration
	localparam IDLE = 0;
	localparam COUNT = 1;

	// Output declaration
	assign shift_ena = (count == 2'b11);

	// Next state and count logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			count <= 2'b0;
		else begin
			if (count == 2'b11)
				count <= 2'b0;
			else
				count <= count + 1;
		end
	end

	// State and count initialization
	always @(posedge clk or posedge reset) begin
		if (reset)
			count <= 2'b0;
		else begin
			case (count)
				2'b00: begin
					if (valid_pattern) // Replace 'valid_pattern' with the actual condition to detect the desired bit pattern
						count <= COUNT;
					else
						count <= 2'b00;
				end
				default: count <= count;
			endcase
		end
	end

endmodule
