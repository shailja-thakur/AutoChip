module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [3:0] count;
	reg [3:0] shift_count;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			count <= 4'd0;
			shift_count <= 4'd0;
			shift_ena <= 1'b1; // assert shift_ena during reset
		end else begin
			if (count < 4'd4) begin
				count <= count + 1;
				shift_ena <= 1'b1; // assert shift_ena for 4 clock cycles
			end else if (shift_count < 4'd2) begin
				shift_ena <= 1'b0; // deassert shift_ena after 4 clock cycles
				shift_count <= shift_count + 1;
			end else begin
				shift_ena <= 1'b0;
			end
		end
	end

endmodule
