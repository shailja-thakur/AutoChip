module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [3:0] count;
	reg shift_ena;

	always @(posedge clk) begin
		if (reset)
			count <= 4'b0000;
		else if (count == 4'b0000)
			count <= 4'b0001;
		else if (count == 4'b0001)
			count <= 4'b0010;
		else if (count == 4'b0010)
			count <= 4'b0011;
		else if (count == 4'b0011)
			count <= 4'b0000;
	end

	always @(posedge clk) begin
		if (reset)
			shift_ena <= 1'b0;
		else if (count == 4'b0000)
			shift_ena <= 1'b1;
		else
			shift_ena <= 1'b0;
	end

endmodule
