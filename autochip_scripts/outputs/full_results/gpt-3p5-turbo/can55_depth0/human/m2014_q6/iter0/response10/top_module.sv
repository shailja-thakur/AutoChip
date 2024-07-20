module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	reg [2:0] state;
	
	always @(posedge clk, posedge reset) begin
		if (reset)
			state <= 3'b000;
		else begin
			case (state)
				3'b000: begin
					if (w)
						state <= 3'b000;
					else
						state <= 3'b001;
				end
				3'b001: begin
					if (w)
						state <= 3'b000;
					else
						state <= 3'b010;
				end
				3'b010: begin
					if (w)
						state <= 3'b011;
					else
						state <= 3'b100;
				end
				3'b011: begin
					if (w)
						state <= 3'b000;
					else
						state <= 3'b010;
				end
				3'b100: begin
					if (w)
						state <= 3'b101;
					else
						state <= 3'b010;
				end
				3'b101: begin
					if (w)
						state <= 3'b001;
					else
						state <= 3'b010;
				end
			endcase
		end
	end
	
	always @(state) begin
		case (state)
			3'b000: z = 1'b0;  // Output A
			3'b001: z = 1'b0;  // Output A
			3'b010: z = 1'b0;  // Output B
			3'b011: z = 1'b1;  // Output C
			3'b100: z = 1'b0;  // Output D
			3'b101: z = 1'b1;  // Output E
		endcase
	end
	
endmodule
