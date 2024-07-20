module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output [2:0] g
);
	reg [1:0] state;
	reg [2:1] r_temp;
	always @(posedge clk, negedge resetn)
	begin
		if (!resetn) 
			state <= 2'b00;
		else
			case (state)
				2'b00: begin
					if (r == 3'b000)
						state <= 2'b00;
					else if (r[0])
						state <= 2'b01;
					else if (r[1])
						state <= 2'b10;
					else
						state <= 2'b11;
				end
				2'b01: begin
					if (r[0] && g[0])
						state <= 2'b01;
					else 
						state <= 2'b00;
				end
				2'b10: begin
					if (r[1] && g[1])
						state <= 2'b10;
					else
						state <= 2'b00;
				end
				2'b11: begin
					if (r == 3'b000)
						state <= 2'b00;
					else if (r[2])
						state <= 2'b00;
					else
						state <= 2'b11;
				end
			endcase
		end
	end
	
	always @(state)
	begin
		case (state)
			2'b00: g <= 3'b000;
			2'b01: g <= 3'b100;
			2'b10: g <= 3'b010;
			2'b11: g <= 3'b001;
		endcase
	end
endmodule
