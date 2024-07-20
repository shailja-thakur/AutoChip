module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// Define the states
	reg [2:0] state;

	// Next state logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000;
		else begin
			case(state)
				3'b000: begin
					if (w)
						state <= 3'b000;
					else
						state <= 3'b001;
				end
				3'b001: begin
					if (w)
						state <= 3'b010;
					else
						state <= 3'b000;
				end
				3'b010: begin
					if (w)
						state <= 3'b101;
					else
						state <= 3'b010;
				end
				3'b011: begin
					if (w)
						state <= 3'b000;
					else
						state <= 3'b010;
				end
				3'b100: begin
					if (w)
						state <= 3'b011;
					else
						state <= 3'b101;
				end
				3'b101: begin
					if (w)
						state <= 3'b111;
					else
						state <= 3'b011;
				end
				3'b110: begin
					if (w)
						state <= 3'b100;
					else
						state <= 3'b101;
				end
				3'b111: begin
					if (w)
						state <= 3'b010;
					else
						state <= 3'b011;
				end
			endcase
		end
	end

	// Output logic
	always @(state) begin
		case(state)
			3'b000: z = 1'b0;
			3'b001: z = 1'b0;
			3'b010: z = 1'b0;
			3'b011: z = 1'b0;
			3'b100: z = 1'b0;
			3'b101: z = 1'b0;
			3'b110: z = 1'b1;
			3'b111: z = 1'b0;
		endcase
	end
	
endmodule
