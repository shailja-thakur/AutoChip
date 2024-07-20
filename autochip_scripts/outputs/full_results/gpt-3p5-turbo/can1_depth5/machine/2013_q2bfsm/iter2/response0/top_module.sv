module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

reg [3:0] state, next_state;

always @(posedge clk or negedge resetn) begin
	if (!resetn)
		state <= 4'b0000;
	else
		state <= next_state;
end

always @* begin
	case (state)
		4'b0000: begin // A
			if (x)
				next_state = 4'b0010; // B
			else
				next_state = 4'b0000; // A
		end
		4'b0010: begin // B
			next_state = 4'b0001; // S0
		end
		4'b0001: begin // S0
			if (x)
				next_state = 4'b0011; // S1
			else
				next_state = 4'b0001; // S0
		end
		4'b0011: begin // S1
			if (x)
				next_state = 4'b0011; // S1
			else
				next_state = 4'b1010; // S10
		end
		4'b1010: begin // S10
			if (x)
				next_state = 4'b1000; // G1
			else
				next_state = 4'b0010; // S0
		end
		4'b1000: begin // G1
			if (y)
				next_state = 4'b1100; // P1
			else
				next_state = 4'b1001; // G2
		end
		4'b1001: begin // G2
			if (y)
				next_state = 4'b1100; // P1
			else
				next_state = 4'b0110; // P0
		end
		4'b0110: begin // P0
			next_state = 4'b0110; // P0
		end
		4'b1100: begin // P1
			next_state = 4'b1100; // P1
		end
	endcase
end

// Assign outputs based on state
always @* begin
	case(state)
		4'b0010: f = 1'b1; // B
		default: f = 1'b0; // Not B
	endcase
	
	case(state)
		4'b1000, 4'b1001, 4'b1100: g = 1'b1; // G1 or G2 or P1
		default: g = 1'b0; // Not G1, G2, or P1
	endcase
end

endmodule
