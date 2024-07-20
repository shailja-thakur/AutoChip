module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output reg [3:1] g
);

reg [3:1] state, next_state;

always @(posedge clk) begin
	if (resetn == 0) begin
		state <= 3'b001; // Assigning A state
	end else begin
		state <= next_state;
	end
end

always @(state or r) begin
	case (state)
		3'b001: begin // A state
			if (r[3] == 1) begin
				next_state = 3'b100; // D state
			end else if (r[2] == 1) begin
				next_state = 3'b011; // C state
			end else if (r[1] == 1) begin
				next_state = 3'b010; // B state
			end else begin
				next_state = 3'b001; // A state
			end
		end
		3'b010: begin // B state
			if (r[1] == 1) begin
				next_state = 3'b010; // B state
			end else begin
				next_state = 3'b001; // A state
			end
		end
		3'b011: begin // C state
			if (r[2] == 1) begin
				next_state = 3'b011; // C state
			end else begin
				next_state = 3'b001; // A state
			end
		end
		3'b100: begin // D state
			if (r[3] == 1) begin
				next_state = 3'b100; // D state
			end else begin
				next_state = 3'b001; // A state
			end
		end
	endcase
end

always @(state) begin
	case (state)
		3'b001: g = 3'b000; // A state
		3'b010: g = {1'b1, 2'b00}; // B state
		3'b011: g = {1'b0, 1'b1, 1'b0}; // C state
		3'b100: g = {1'b0, 2'b00, 1'b1}; // D state
	endcase
end

endmodule
