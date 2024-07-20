module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4;
	reg [2:0] state;
	reg [2:0] next_state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= S0;
		end else begin
			state <= next_state;
		end
	end
	
	always @(state or in) begin
		case(state)
			S0: begin
				if (in) begin
					next_state = S1;
				end else begin
					next_state = S0;
				end
			end
			S1: begin
				if (in) begin
					next_state = S2;
				end else begin
					next_state = S0;
				end
			end
			S2: begin
				if (in) begin
					next_state = S3;
				end else begin
					next_state = S0;
				end
			end
			S3: begin
				if (in) begin
					next_state = S4;
				end else begin
					next_state = S0;
				end
			end
			S4: begin
				if (in) begin
					next_state = S4;
				end else begin
					next_state = S0;
				end
			end
			default: next_state = S0;
		endcase
	end
	
	always @(state) begin
		case(state)
			S0: begin
				disc = 0;
				flag = 0;
				err = 0;
			end
			S1: begin
				disc = 0;
				flag = 0;
				err = 0;
			end
			S2: begin
				disc = 0;
				flag = 0;
				err = 0;
			end
			S3: begin
				disc = 0;
				flag = 0;
				err = 0;
			end
			S4: begin
				disc = 0;
				flag = 1;
				err = 0;
			end
			default: begin
				disc = 0;
				flag = 0;
				err = 0;
			end
		endcase
	end
endmodule
