module top_module(
	input clock,
	input reset,
	output reg data_output,
	output reg valid_output);

	reg [1:0] state;
	reg [7:0] counter;

	always @(posedge clock or posedge reset) begin
		if (reset)
			state <= 0;
		else if (state == 0)
			state <= 1;
		else if (state == 1 && counter < 8)
			state <= 1;
		else if (state == 1 && counter == 8)
			state <= 2;
		else if (state == 2)
			state <= 3;
		else if (state == 3)
			state <= 0;
	end

	always @(posedge clock or posedge reset) begin
		if (reset)
			counter <= 0;
		else if (state == 0 || state == 3)
			counter <= 0;
		else if (state == 1 || state == 2)
			counter <= counter + 1;
	end

	always @(posedge clock or posedge reset) begin
		if (reset)
			data_output <= 0;
		else if (state == 2)
			data_output <= in;
	end

	always @(posedge clock or posedge reset) begin
		if (reset)
			valid_output <= 0;
		else if (state == 3)
			valid_output <= 1;
		else
			valid_output <= 0;
	end

endmodule
