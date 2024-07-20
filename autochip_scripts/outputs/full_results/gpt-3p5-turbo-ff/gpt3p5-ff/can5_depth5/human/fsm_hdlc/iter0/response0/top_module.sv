module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	reg [2:0] state;
	reg flag_next = 0;
	reg err_next = 0;

	parameter IDLE = 0;
	parameter S1 = 1;
	parameter S2 = 2;
	parameter S3 = 3;
	parameter S4 = 4;
	parameter S5 = 5;
	parameter S6 = 6;
	parameter S7 = 7;

	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= IDLE;
		else
			case (state)
				IDLE:
					if (in)
						state <= S1;
					else
						state <= IDLE;
				S1:
					if (in)
						state <= S2;
					else
						state <= IDLE;
				S2:
					if (in)
						state <= S3;
					else
						state <= IDLE;
				S3:
					if (in)
						state <= S4;
					else
						state <= IDLE;
				S4:
					if (in)
						state <= S5;
					else
						state <= IDLE;
				S5:
					if (in)
						state <= S6;
					else
						state <= IDLE;
				S6:
					if (in)
					begin
						state <= S7;
						err_next <= 1;
					end
					else
					begin
						state <= S2;
						flag_next <= 0;
					end
				S7:
					if (in)
					begin
						state <= S7;
						err_next <= 1;
					end
					else
					begin
						state <= S2;
						flag_next <= 1;
					end
			endcase
	end

	always @(posedge clk)
	begin
		if (reset)
		begin
			flag <= 0;
			err <= 0;
		end
		else
		begin
			flag <= flag_next;
			err <= err_next;
		end

		disc <= (state == S4) && in;
	end

endmodule
