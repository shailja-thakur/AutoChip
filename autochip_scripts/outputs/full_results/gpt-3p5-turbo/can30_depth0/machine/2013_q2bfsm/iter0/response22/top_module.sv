module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

	reg [3:0] state;

	always @(posedge clk or negedge resetn) begin
		if (~resetn)
			state <= 4'b0;
		else begin
			case (state)
				4'b0000: begin
					if (x)
						state <= 4'b0010;
					else
						state <= 4'b0000;
				end
				4'b0010: begin
					if (x)
						state <= 4'b0011;
					else
						state <= 4'b0000;
				end
				4'b0011: begin
					if (x)
						state <= 4'b0011;
					else
						state <= 4'b0110;
				end
				4'b0110: begin
					if (x)
						state <= 4'b1000;
					else
						state <= 4'b0000;
				end
				4'b1000: begin
					if (y)
						state <= 4'b1010;
					else
						state <= 4'b1100;
				end
				4'b1010: begin
					state <= 4'b1110;
				end
				4'b1100: begin
					state <= 4'b1111;
				end
				4'b1110: begin
					state <= 4'b1010;
				end
				4'b1111: begin
					state <= 4'b1100;
				end
				default: state <= 4'b0;
			endcase
		end
	end
	
	assign f = (state == 4'b0010);
	assign g = (state == 4'b1000 || state == 4'b1010 || state == 4'b1100);

endmodule
