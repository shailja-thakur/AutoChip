module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);
	
	reg [2:0] state;
	parameter [2:0] S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;
	parameter [2:0] S5 = 3'b101, S6 = 3'b110;
	reg disc_pulse, flag_pulse, err_pulse;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= S0;
		end else begin
			case(state)
				S0: begin
					if (in) begin
						state <= S1;
					end else begin
						state <= S0;
					end
				end
				S1: begin
					if (in) begin
						state <= S2;
					end else begin
						state <= S0;
					end
				end
				S2: begin
					if (in) begin
						state <= S3;
					end else begin
						state <= S0;
					end
				end
				S3: begin
					if (in) begin
						state <= S4;
					end else begin
						state <= S0;
					end
				end
				S4: begin
					if (in) begin
						state <= S5;
					end else begin
						state <= S0;
					end
				end
				S5: begin
					if (in) begin
						state <= S6;
					end else begin
						state <= S0;
					end
				end
				S6: begin
					if (in) begin
						state <= S6;
					end else begin
						state <= S0;
					end
				end
			endcase
		end
	end
	
	always @(state) begin
		case(state)
			S0: begin
				disc_pulse <= 0;
				flag_pulse <= 0;
				err_pulse <= 0;
			end
			S1: begin
				disc_pulse <= 0;
				flag_pulse <= 0;
				err_pulse <= 0;
			end
			S2: begin
				disc_pulse <= 0;
				flag_pulse <= 0;
				err_pulse <= 0;
			end
			S3: begin
				disc_pulse <= 0;
				flag_pulse <= 0;
				err_pulse <= 0;
			end
			S4: begin
				disc_pulse <= 1;
				flag_pulse <= 0;
				err_pulse <= 0;
			end
			S5: begin
				disc_pulse <= 0;
				flag_pulse <= 1;
				err_pulse <= 0;
			end
			S6: begin
				disc_pulse <= 0;
				flag_pulse <= 0;
				err_pulse <= 1;
			end
		endcase
	end
	
	assign disc = disc_pulse;
	assign flag = flag_pulse;
	assign err = err_pulse;
	
endmodule
