module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	reg [2:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000; // initial state A
		end else begin
			case (state)
				3'b000: begin // state A
					if (w) begin
						state <= 3'b001; // transition to state B
					end else begin
						state <= 3'b000; // stay in state A
					end
				end
				3'b001: begin // state B
					if (w) begin
						state <= 3'b010; // transition to state C
					end else begin
						state <= 3'b100; // transition to state D
					end
				end
				3'b010: begin // state C
					if (w) begin
						state <= 3'b100; // transition to state E
					end else begin
						state <= 3'b100; // stay in state C
					end
				end
				3'b011: begin // state D
					if (w) begin
						state <= 3'b110; // transition to state F
					end else begin
						state <= 3'b000; // transition to state A
					end
				end
				3'b100: begin // state E
					if (w) begin
						state <= 3'b100; // stay in state E
					end else begin
						state <= 3'b100; // transition to state D
					end
				end
				3'b101: begin // state F
					if (w) begin
						state <= 3'b010; // transition to state C
					end else begin
						state <= 3'b110; // stay in state F
					end
				end
				default: state <= 3'b000; // default to state A
			endcase
		end
	end

	assign z = (state == 3'b100) || (state == 3'b101); // z = 1 when in state E or F

endmodule
