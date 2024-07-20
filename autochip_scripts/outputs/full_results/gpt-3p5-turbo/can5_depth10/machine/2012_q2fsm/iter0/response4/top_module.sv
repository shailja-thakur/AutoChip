module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state;
wire z;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b000; // initial state is A
	end else begin
		case (state)
			3'b000: // A
				if (w) begin
					state <= 3'b001; // next state is B
				end else begin
					state <= 3'b000; // next state is A
				end
			3'b001: // B
				if (w) begin
					state <= 3'b010; // next state is C
				end else begin
					state <= 3'b100; // next state is D
				end
			3'b010: // C
				if (w) begin
					state <= 3'b100; // next state is D
				end else begin
					state <= 3'b011; // next state is E
				end
			3'b011: // D
				if (w) begin
					state <= 3'b011; // next state is E
				end else begin
					state <= 3'b000; // next state is A
				end
			3'b100: // E
				if (w) begin
					state <= 3'b010; // next state is C
				end else begin
					state <= 3'b011; // next state is E
				end
			3'b101: // F
				if (w) begin
					state <= 3'b010; // next state is C
				end else begin
					state <= 3'b100; // next state is D
				end
		endcase
	end
end

assign z = (state == 3'b100) || (state == 3'b101);

endmodule
