module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b000;
	end else begin
		state <= next_state;
	end
end

always @* begin
	case(state)
		3'b000: begin // A
			if (w) begin
				next_state = 3'b000; // A
			end else begin
				next_state = 3'b001; // B
			end
		end
		3'b001: begin // B
			if (w) begin
				next_state = 3'b010; // C
			end else begin
				next_state = 3'b011; // D
			end
		end
		3'b010: begin // C
			if (w) begin
				next_state = 3'b110; // E
			end else begin
				next_state = 3'b011; // D
			end
		end
		3'b011: begin // D
			if (w) begin
				next_state = 3'b100; // F
			end else begin
				next_state = 3'b000; // A
			end
		end
		3'b100: begin // F
			if (w) begin
				next_state = 3'b010; // C
			end else begin
				next_state = 3'b011; // D
			end
		end
		3'b110: begin // E
			if (w) begin
				next_state = 3'b110; // E
			end else begin
				next_state = 3'b011; // D
			end
		end
	endcase
end

assign z = (state == 3'b110);

endmodule
