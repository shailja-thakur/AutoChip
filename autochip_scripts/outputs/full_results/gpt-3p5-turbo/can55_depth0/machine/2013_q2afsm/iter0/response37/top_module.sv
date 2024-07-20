module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk) begin
	if (!resetn) begin
		state <= 2'b00; // Set state to A
	end else begin
		state <= next_state; // Update state to next_state
	end
end

always @* begin
	case (state)
		2'b00: begin // State A
			if (r[1]) begin
				next_state = 2'b01; // Next state is B
			end else if (r[2]) begin
				next_state = 2'b10; // Next state is C
			end else if (r[3]) begin
				next_state = 2'b11; // Next state is D
			end else begin
				next_state = 2'b00; // Next state is A
			end
		end
		2'b01: begin // State B
			if (r[1]) begin
				next_state = 2'b01; // Next state is B
			end else begin
				next_state = 2'b00; // Next state is A
			end
		end
		2'b10: begin // State C
			if (r[2]) begin
				next_state = 2'b10; // Next state is C
			end else begin
				next_state = 2'b00; // Next state is A
			end
		end
		2'b11: begin // State D
			if (r[3]) begin
				next_state = 2'b11; // Next state is D
			end else begin
				next_state = 2'b00; // Next state is A
			end
		end
	endcase
end

always @* begin
	case (state)
		2'b00: begin // State A
			g = 3'b000; // All bits of g are low
		end
		2'b01: begin // State B
			g = {2'b01, r[2:1]}; // Set g[1] high, other bits are r[2:1]
		end
		2'b10: begin // State C
			g = {r[3], 2'b01, r[1]}; // Set g[2] high, other bits are r[3], 0, r[1]
		end
		2'b11: begin // State D
			g = {r[3:2], 2'b01}; // Set g[3] high, other bits are r[3:2], 0
		end
	endcase
end

endmodule
