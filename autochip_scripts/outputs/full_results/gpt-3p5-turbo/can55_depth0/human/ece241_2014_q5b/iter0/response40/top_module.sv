module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	reg [1:0] state;
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b00;
		else
			case (state)
				2'b00: begin
					if (x)
						state <= 2'b01;
					else
						state <= 2'b00;
				end
				2'b01: begin
					if (x)
						state <= 2'b00;
					else
						state <= 2'b01;
				end
			endcase
		end
	end

	always @(state) begin
		case (state)
			2'b00: z = 1'b0;
			2'b01: z = 1'b1;
		endcase
	end
endmodule
