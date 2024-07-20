module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [2:0] count;

	always @(posedge clk) begin
		if (reset) begin
			count <= 3'b100; // initialize counter to 4 cycles
		end else if (count != 3'b000) begin
			count <= count - 1;
		end
	end

	always @(posedge clk) begin
		if (reset) begin
			shift_ena <= 1;
		end else if (count == 3'b000) begin
			shift_ena <= 0;
		end else begin
			shift_ena <= 1;
		end
	end
	
endmodule
