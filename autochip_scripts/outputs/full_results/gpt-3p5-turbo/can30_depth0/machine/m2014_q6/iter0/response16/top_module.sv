module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	reg [2:0] state_reg;
	reg [2:0] next_state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state_reg <= 3'b000;
		else
			state_reg <= next_state;
	end

	always @(*) begin
		case (state_reg)
			3'b000: begin // State A
				if (w == 1'b1)
					next_state = 3'b000;
				else
					next_state = 3'b001;
			end
			
			3'b001: begin // State B
				if (w == 1'b1)
					next_state = 3'b010;
				else
					next_state = 3'b011;
			end
			
			3'b010: begin // State C
				if (w == 1'b1)
					next_state = 3'b010;
				else
					next_state = 3'b100;
			end
			
			3'b011: begin // State D
				if (w == 1'b1)
					next_state = 3'b000;
				else
					next_state = 3'b101;
			end
			
			3'b100: begin // State E
				if (w == 1'b1)
					next_state = 3'b011;
				else
					next_state = 3'b100;
			end
			
			3'b101: begin // State F
				if (w == 1'b1)
					next_state = 3'b011;
				else
					next_state = 3'b010;
			end
			
			default: next_state = 3'b000;
		endcase
	end

	assign z = (state_reg == 3'b100 || state_reg == 3'b101) ? 1'b1 : 1'b0;

endmodule
