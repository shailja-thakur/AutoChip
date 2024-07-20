module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [2:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000;
		else if (state == 3'b000 && data)
			state <= 3'b001;
		else if (state == 3'b000 && !data)
			state <= 3'b000;
		else if (state == 3'b001 && data)
			state <= 3'b011;
		else if (state == 3'b001 && !data)
			state <= 3'b000;
		else if (state == 3'b011 && data)
			state <= 3'b011;
		else if (state == 3'b011 && !data)
			state <= 3'b110;
		else if (state == 3'b110 && data)
			state <= 3'b111;
		else if (state == 3'b110 && !data)
			state <= 3'b000;
		else if (state == 3'b111)
			state <= 3'b111;
	end

	always @(state) begin
		if (state == 3'b111)
			start_shifting = 1'b1;
		else
			start_shifting = 1'b0;
	end

endmodule
