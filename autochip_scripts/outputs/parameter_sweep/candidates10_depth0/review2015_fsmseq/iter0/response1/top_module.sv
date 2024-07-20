module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	reg [1:0] state;
	reg [1:0] next_state;
	reg start_shifting;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00;
		else
			state <= next_state;
	end

	always @* begin
		case (state)
			2'b00:
				if (data)
					next_state = 2'b01;
				else
					next_state = 2'b00;
			2'b01:
				if (data)
					next_state = 2'b10;
				else
					next_state = 2'b00;
			2'b10:
				if (data)
					next_state = 2'b11;
				else
					next_state = 2'b00;
			2'b11:
				if (data)
					next_state = 2'b11;
				else
					next_state = 2'b00;
			default:
				next_state = 2'b00;
		endcase
	end

	always @(posedge clk or posedge reset) begin
		if (reset)
			start_shifting <= 1'b0;
		else if (state == 2'b11)
			start_shifting <= 1'b1;
		else
			start_shifting <= 1'b0;
	end

endmodule
