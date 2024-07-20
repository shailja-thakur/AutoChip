module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	reg [2:0] state;
	reg disc_reg;
	reg flag_reg;
	reg err_reg;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000;
			disc_reg <= 1'b0;
			flag_reg <= 1'b0;
			err_reg <= 1'b0;
		end else begin
			case (state)
				3'b000: begin
					if (in == 1'b0)
						state <= 3'b000;
					else if (in == 1'b1)
						state <= 3'b001;
				end
				
				3'b001: begin
					if (in == 1'b0)
						state <= 3'b010;
					else if (in == 1'b1)
						state <= 3'b001;
				end
				
				3'b010: begin
					if (in == 1'b0)
						state <= 3'b000;
					else if (in == 1'b1)
						state <= 3'b011;
				end
				
				3'b011: begin
					if (in == 1'b0) begin
						state <= 3'b100;
						disc_reg <= 1'b1;
					end else if (in == 1'b1)
						state <= 3'b011;
				end
				
				3'b100: begin
					if (in == 1'b0)
						state <= 3'b010;
					else if (in == 1'b1) begin
						state <= 3'b101;
						flag_reg <= 1'b1;
					end
				end
				
				3'b101: begin
					if (in == 1'b0)
						state <= 3'b010;
					else if (in == 1'b1) begin
						state <= 3'b110;
						err_reg <= 1'b1;
					end
				end
				
				3'b110: begin
					if (in == 1'b0)
						state <= 3'b010;
					else if (in == 1'b1)
						state <= 3'b110;
				end
			endcase
		end
	end
	
	assign disc = disc_reg;
	assign flag = flag_reg;
	assign err = err_reg;
	
endmodule
