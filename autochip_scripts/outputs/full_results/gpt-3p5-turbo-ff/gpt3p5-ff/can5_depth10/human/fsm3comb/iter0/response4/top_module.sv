module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

always @ (in, state) begin
	case (state)
		2'b00:
			if (in == 1'b0) begin
				next_state = 2'b00; // A
				out = 1'b0;
			end
			else begin
				next_state = 2'b01; // B
				out = 1'b0;
			end
		2'b01:
			if (in == 1'b0) begin
				next_state = 2'b10; // C
				out = 1'b0;
			end
			else begin
				next_state = 2'b01; // B
				out = 1'b0;
			end
		2'b10:
			if (in == 1'b0) begin
				next_state = 2'b00; // A
				out = 1'b0;
			end
			else begin
				next_state = 2'b11; // D
				out = 1'b0;
			end
		2'b11:
			if (in == 1'b0) begin
				next_state = 2'b10; // C
				out = 1'b1;
			end
			else begin
				next_state = 2'b01; // B
				out = 1'b0;
			end
	endcase
end

endmodule
