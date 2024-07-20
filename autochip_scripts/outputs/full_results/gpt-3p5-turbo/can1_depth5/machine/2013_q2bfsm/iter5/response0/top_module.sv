module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

reg [2:0] state, next_state;

always @(posedge clk or negedge resetn) begin
	if (!resetn)
		state <= 3'b000;
	else
		state <= next_state;
end

always @* begin
	case (state)
		3'b000: begin // A
			if (x)
				next_state = 3'b010; // B
			else
				next_state = 3'b000; // A
		end
		3'b010: begin // B
			next_state = 3'b001; // S0
		end
		3'b001: begin // S0
			if (x)
				next_state = 3'b011; // S1
			else
				next_state = 3'b010; // S0
		end
		3'b011: begin // S1
			if (x)
				next_state = 3'b011; // S1
			else
				next_state = 3'b101; // S10
		end
		3'b101: begin // S10
			if (x)
				next_state = 3'b100; // G1
			else
				next_state = 3'b001; // S0
		end
		3'b100: begin // G1
			if (y)
				next_state = 3'b110; // P1
			else
				next_state = 3'b101; // G2
		end
		3'b101: begin // G2
			if (y)
				next_state = 3'b110; // P1
			else
				next_state = 3'b011; // P0
		end
		3'b011: begin // P0
			next_state = 3'b011; // P0
		end
		3'b110: begin // P1
			next_state = 3'b110; // P1
		end
	endcase
end

always @(posedge clk) begin
	case (state)
		3'b010: f <= 1'b1; // B
		default: f <= 1'b0; // Not B
	endcase
	
	case (state)
		3'b100, 3'b101, 3'b110: g <= 1'b1; // G1, G2, P1
		default: g <= 1'b0; // Not G1, G2, P1
	endcase
end

endmodule
