module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [1:0] state;

always @(posedge clk) begin
	if (reset) begin
		state <= 0;
	end else begin
		case(state)
			0: begin // state A
				if (s) begin
					state <= 1; // move to state B
				end else begin
					state <= 0; // stay in state A
				end
			end
			1: begin // state B
				if (w) begin
					state <= 2; // move to state C
				end else begin
					state <= 1; // stay in state B
				end
			end
			2: begin // state C
				state <= 3; // move to state D
			end
			3: begin // state D
				state <= 4; // move to state E
			end
			4: begin // state E
				if (w) begin
					state <= 5; // move to state F
				end else begin
					state <= 1; // move back to state B
				end
			end
			5: begin // state F
				if (w) begin
					state <= 6; // move to state G
				end else begin
					state <= 1; // move back to state B
				end
			end
			6: begin // state G
				state <= 7; // move to state H
			end
			7: begin // state H
				if (w) begin
					state <= 8; // move to state I
				end else begin
					state <= 1; // move back to state B
				end
			end
			8: begin // state I
				if (w) begin
					state <= 9; // move to state J
				end else begin
					state <= 1; // move back to state B
				end
			end
			9: begin // state J
				if (w) begin
					z <= 1; // set output z to 1
				end else begin
					z <= 0; // set output z to 0
				end
				state <= 1; // move back to state B
			end
		endcase
	end
end

endmodule
