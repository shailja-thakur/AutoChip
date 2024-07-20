module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output reg out
);

always @(state or in) begin
	case(state)
		2'b00: begin // State A
			if (in == 0) begin
				next_state = 2'b00; // Next state = A
				out = 0;
			end
			else if (in == 1) begin
				next_state = 2'b01; // Next state = B
				out = 0;
			end
		end
		2'b01: begin // State B
			if (in == 0) begin
				next_state = 2'b10; // Next state = C
				out = 0;
			end
			else if (in == 1) begin
				next_state = 2'b01; // Next state = B
				out = 0;
			end
		end
		2'b10: begin // State C
			if (in == 0) begin
				next_state = 2'b00; // Next state = A
				out = 0;
			end
			else if (in == 1) begin
				next_state = 2'b11; // Next state = D
				out = 0;
			end
		end
		2'b11: begin // State D
			if (in == 0) begin
				next_state = 2'b10; // Next state = C
				out = 1;
			end
			else if (in == 1) begin
				next_state = 2'b01; // Next state = B
				out = 0;
			end
		end
	endcase
end

endmodule
