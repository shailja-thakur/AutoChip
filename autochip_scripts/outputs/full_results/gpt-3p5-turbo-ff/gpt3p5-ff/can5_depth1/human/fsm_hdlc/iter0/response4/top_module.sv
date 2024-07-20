module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	reg [2:0] state, next_state;

	parameter S0 = 3'b000;
	parameter S1 = 3'b001;
	parameter S2 = 3'b010;
	parameter S3 = 3'b011;
	parameter S4 = 3'b100;
	parameter S5 = 3'b101;

	always @(posedge clk or posedge reset)
	begin
		if(reset)
			state <= S0;
		else
			state <= next_state;
	end

	always @*
	begin
		case(state)
			S0: begin
					if(in)
						next_state = S1;
					else
						next_state = S0;
					disc = 0;
					flag = 0;
					err = 0;
					end
			S1: begin
					if(in)
						next_state = S2;
					else
						next_state = S0;
					disc = 0;
					flag = 0;
					err = 0;
					end
			S2: begin
					if(in)
						next_state = S3;
					else
						next_state = S0;
					disc = 0;
					flag = 0;
					err = 0;
					end
			S3: begin
					if(in)
						next_state = S4;
					else
						next_state = S0;
					disc = 1;
					flag = 0;
					err = 0;
					end
			S4: begin
					if(in)
						next_state = S5;
					else
						next_state = S0;
					disc = 0;
					flag = 1;
					err = 0;
					end
			S5: begin
					if(in)
						next_state = S4;
					else
						next_state = S0;
					disc = 0;
					flag = 0;
					err = 1;
					end
			default: begin
						next_state = S0;
						disc = 0;
						flag = 0;
						err = 0;
						end
		endcase
	end

endmodule
