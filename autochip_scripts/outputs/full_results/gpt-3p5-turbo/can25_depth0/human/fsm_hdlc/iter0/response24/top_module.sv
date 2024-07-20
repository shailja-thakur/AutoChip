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

	reg [1:0] state;
	reg disc_reg, flag_reg, err_reg;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= S0;
			disc_reg <= 0;
			flag_reg <= 0;
			err_reg <= 0;
		end else begin
			case (state)
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
						disc_reg <= 1;
						flag_reg <= 0;
						err_reg <= 0;
					end else begin
						state <= S0;
						disc_reg <= 0;
						flag_reg <= 0;
						err_reg <= 0;
					end
				end
				S2: begin
					if (in) begin
						state <= S2;
						disc_reg <= 0;
						flag_reg <= 0;
						err_reg <= 1;
					end else begin
						state <= S0;
						disc_reg <= 0;
						flag_reg <= 1;
						err_reg <= 0;
					end
				end
				default: begin
					state <= S0;
					disc_reg <= 0;
					flag_reg <= 0;
					err_reg <= 0;
				end
			endcase
		end
	end
	
	assign disc = disc_reg;
	assign flag = flag_reg;
	assign err = err_reg;
    
endmodule
