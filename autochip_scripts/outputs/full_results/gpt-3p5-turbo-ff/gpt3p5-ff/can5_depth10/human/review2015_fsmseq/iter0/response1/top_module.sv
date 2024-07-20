module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;
	reg [3:0] next_state;

	parameter [3:0] IDLE = 4'b0000;
	parameter [3:0] S0 = 4'b0001;
	parameter [3:0] S1 = 4'b0010;
	parameter [3:0] S2 = 4'b0100;
	parameter [3:0] S3 = 4'b1000;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= IDLE;
		else
			state <= next_state;
	end
	
	always @(state or data) begin
		case (state)
			IDLE:
				if (data)
					next_state = S0;
				else
					next_state = IDLE;
			S0:
				if (data)
					next_state = S0;
				else
					next_state = S1;
			S1:
				if (data)
					next_state = S2;
				else
					next_state = IDLE;
			S2:
				if (data)
					next_state = S0;
				else
					next_state = S3;
			S3:
				if (data)
					next_state = S0;
				else
					next_state = IDLE;
			default:
				next_state = IDLE;
		endcase
	end
	
	always @(state) begin
		if (state == S3)
			start_shifting = 1;
		else
			start_shifting = 0;
	end
endmodule
