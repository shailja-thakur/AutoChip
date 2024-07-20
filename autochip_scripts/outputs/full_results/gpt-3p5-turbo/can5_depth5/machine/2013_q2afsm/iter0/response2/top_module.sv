module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output [2:0] g
);

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		state <= 2'b00; // Set state to A
	end else begin
		state <= next_state; // Update state
	end
end

always @* begin
	case(state)
		2'b00: begin // State A
			if (r[2]) begin
				next_state = 2'b01; // Next state is B
			end else if (r[1]) begin
				next_state = 2'b10; // Next state is C
			end else if (r[0]) begin
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
			if (r[0]) begin
				next_state = 2'b11; // Next state is D
			end else begin
				next_state = 2'b00; // Next state is A
			end
		end
	endcase
end

assign g[2] = (state == 2'b10) ? 1'b1 : 1'b0; // Set g[2] to 1 if state is C, otherwise 0
assign g[1] = (state == 2'b01) ? 1'b1 : 1'b0; // Set g[1] to 1 if state is B, otherwise 0
assign g[0] = (state == 2'b11) ? 1'b1 : 1'b0; // Set g[0] to 1 if state is D, otherwise 0

endmodule
