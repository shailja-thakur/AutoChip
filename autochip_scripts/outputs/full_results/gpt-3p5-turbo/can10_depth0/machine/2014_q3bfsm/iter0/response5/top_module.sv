module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk) begin
	if (reset) begin
		state <= 3'b001; // initialize state to A
	end else begin
		state <= next_state;
	end
end

always @(state or x) begin
	case (state)
		3'b000: begin // A
			if (x) begin
				next_state = 3'b010; // B
			end else begin
				next_state = 3'b000; // A
			end
		end
		3'b001: begin // B
			if (x) begin
				next_state = 3'b100; // E
			end else begin
				next_state = 3'b001; // B
			end
		end
		3'b010: begin // C
			if (x) begin
				next_state = 3'b001; // B
			end else begin
				next_state = 3'b010; // C
			end
		end
		3'b011: begin // D
			if (x) begin
				next_state = 3'b010; // B
			end else begin
				next_state = 3'b011; // D
			end
		end
		3'b100: begin // E
			if (x) begin
				next_state = 3'b100; // E
			end else begin
				next_state = 3'b011; // D
			end
		end
	endcase
end

assign z = (state == 3'b100 || state == 3'b101) ? 1'b1 : 1'b0;

endmodule
