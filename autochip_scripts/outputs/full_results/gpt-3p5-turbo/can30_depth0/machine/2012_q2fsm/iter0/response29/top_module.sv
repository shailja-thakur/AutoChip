module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

reg [2:0] state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b000; // initial state is A
	end else begin
		case (state)
			3'b000: begin
				if (w) begin
					state <= 3'b001; // transition from A to B
				end else begin
					state <= 3'b000; // stay in A
				end
			end
			3'b001: begin
				if (w) begin
					state <= 3'b010; // transition from B to C
				end else begin
					state <= 3'b100; // transition from B to D
				end
			end
			3'b010: begin
				if (w) begin
					state <= 3'b110; // transition from C to E
				end else begin
					state <= 3'b100; // stay in D
				end
			end
			3'b100: begin
				if (w) begin
					state <= 3'b011; // transition from D to F
				end else begin
					state <= 3'b000; // transition from D to A
				end
			end
			3'b110: begin
				if (w) begin
					state <= 3'b110; // stay in E
				end else begin
					state <= 3'b100; // transition from E to D
				end
			end
			3'b011: begin
				if (w) begin
					state <= 3'b110; // transition from F to E
				end else begin
					state <= 3'b010; // transition from F to C
				end
			end
			default: begin
				state <= 3'b000; // default state is A
			end
		endcase
	end
end

assign z = (state == 3'b110) || (state == 3'b011); // set z to 1 when state is E or F

endmodule
