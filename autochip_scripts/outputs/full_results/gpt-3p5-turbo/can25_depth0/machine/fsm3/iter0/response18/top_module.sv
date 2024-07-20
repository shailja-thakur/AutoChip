module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 2'b00; // A
	end else begin
		state <= next_state;
	end
end

always @(state or in) begin
	case (state)
		2'b00: begin // A
			if (in) begin
				next_state = 2'b01; // B
			end else begin
				next_state = 2'b00; // A
			end
		end
		2'b01: begin // B
			if (in) begin
				next_state = 2'b01; // B
			end else begin
				next_state = 2'b10; // C
			end
		end
		2'b10: begin // C
			if (in) begin
				next_state = 2'b11; // D
			end else begin
				next_state = 2'b00; // A
			end
		end
		2'b11: begin // D
			if (in) begin
				next_state = 2'b01; // B
			end else begin
				next_state = 2'b10; // C
			end
		end
	endcase
end

always @(state) begin
	if (state == 2'b11) begin // D
		out = 1;
	end else begin
		out = 0;
	end
end

endmodule
