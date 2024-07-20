module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b000;
	end else begin
		case (state)
			3'b000: begin
				if (w)
					state <= 3'b000; // staying at state A (0)
				else
					state <= 3'b001; // moving to state B (0)
				end
			3'b001: begin
				if (w)
					state <= 3'b000; // moving to state A (0)
				else
					state <= 3'b010; // moving to state C (0)
				end
			3'b010: begin
				if (w)
					state <= 3'b011; // moving to state D (0)
				else
					state <= 3'b100; // moving to state E (1)
				end
			3'b011: begin
				if (w)
					state <= 3'b000; // moving to state A (0)
				else
					state <= 3'b101; // moving to state F (1)
				end
			3'b100: begin
				if (w)
					state <= 3'b101; // moving to state F (1)
				else
					state <= 3'b010; // staying at state C (0)
				end
			3'b101: begin
				if (w)
					state <= 3'b011; // moving to state D (0)
				else
					state <= 3'b110; // staying at state E (1)
				end
			3'b110: begin
				if (w)
					state <= 3'b011; // moving to state D (0)
				else
					state <= 3'b100; // moving to state E (1)
				end
			default: begin
				state <= 3'b000; // default state is A (0)
			end
		endcase
	end
end

assign z = (state == 3'b111);

endmodule
