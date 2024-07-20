module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);
	
	parameter S0 = 2'b00;
	parameter S1 = 2'b01;
	parameter S2 = 2'b10;
	parameter S3 = 2'b11;
	
	reg [1:0] state, next_state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= S0;
		end else begin
			state <= next_state;
		end
	end
	
	always @(*) begin
		case (state)
			S0: begin
				if (in) begin
					next_state = S1;
					disc = 0;
					flag = 0;
					err = 0;
				end else begin
					next_state = S0;
					disc = 0;
					flag = 0;
					err = 0;
				end
			end
			S1: begin
				if (in) begin
					next_state = S2;
					disc = 1;
					flag = 0;
					err = 0;
				end else begin
					next_state = S0;
					disc = 0;
					flag = 0;
					err = 0;
				end
			end
			S2: begin
				if (in) begin
					next_state = S3;
					disc = 0;
					flag = 0;
					err = 0;
				end else begin
					next_state = S0;
					disc = 0;
					flag = 0;
					err = 0;
				end
			end
			S3: begin
				if (in) begin
					next_state = S3;
					disc = 0;
					flag = 0;
					err = 1;
				end else begin
					next_state = S0;
					disc = 0;
					flag = 1;
					err = 0;
				end
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
