module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	
	reg [2:0] state;
	reg z;
	
	always @(posedge clk or negedge areset) begin
		if (areset == 0) begin
			state <= 3'b000;
			z <= 1'b0;
		end else begin
			case (state)
				3'b000: begin
					if (x == 1'b1)
						state <= 3'b001;
					else
						state <= 3'b000;
					z <= 1'b0;
				end
				3'b001: begin
					if (x == 1'b1)
						state <= 3'b010;
					else
						state <= 3'b001;
					z <= 1'b0;
				end
				3'b010: begin
					if (x == 1'b1)
						state <= 3'b011;
					else
						state <= 3'b010;
					z <= 1'b0;
				end
				3'b011: begin
					if (x == 1'b1)
						state <= 3'b011;
					else
						state <= 3'b100;
					z <= 1'b1;
				end
				3'b100: begin
					if (x == 1'b1)
						state <= 3'b101;
					else
						state <= 3'b100;
					z <= 1'b1;
				end
				3'b101: begin
					if (x == 1'b1)
						state <= 3'b110;
					else
						state <= 3'b101;
					z <= 1'b1;
				end
				3'b110: begin
					if (x == 1'b1)
						state <= 3'b111;
					else
						state <= 3'b110;
					z <= 1'b1;
				end
				3'b111: begin
					state <= 3'b111;
					z <= 1'b1;
				end
			endcase
		end
	end
	
endmodule
