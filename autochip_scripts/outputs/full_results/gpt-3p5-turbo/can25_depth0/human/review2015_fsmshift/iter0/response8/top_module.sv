module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [3:0] count;

	always @(posedge clk or posedge reset)
	begin
		if (reset)
			count <= 0;
		else if (count == 4)
			count <= 0;
		else if (/*proper bit pattern detected*/)
			count <= count + 1;
		else
			count <= count;
	end

	assign shift_ena = (count == 4);
endmodule
