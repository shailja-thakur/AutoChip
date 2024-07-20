module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	reg [2:0] state, next_state;
	reg start_shifting;

	parameter IDLE = 3'b000;
	parameter S0 = 3'b001;
	parameter S1 = 3'b010;
	parameter S2 = 3'b011;
	parameter S3 = 3'b100;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= IDLE;
		else
			state <= next_state;
	end

	always @* begin
		case (state)
			IDLE: begin
				if (data == 1'b1)
					next_state = S0;
				else
					next_state = IDLE;
			end
			S0: begin
				if (data == 1'b1)
					next_state = S0;
				else
					next_state = S1;
			end
			S1: begin
				if (data == 1'b1)
					next_state = S0;
				else
					next_state = S2;
			end
			S2: begin
				if (data == 1'b1)
					next_state = S3;
				else
					next_state = S0;
			end
			S3: begin
				if (data == 1'b1)
					next_state = S0;
				else
					next_state = IDLE;
			end
			default: next_state = IDLE;
		endcase
	end

	always @* begin
		if (state == S3)
			start_shifting = 1'b1;
		else
			start_shifting = 1'b0;
	end

endmodule
