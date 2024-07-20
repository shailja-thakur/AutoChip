module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state;
reg z;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b000;  // initial state: A
	end else begin
		case (state)
			3'b000: begin // State A
				if (w) begin
					state <= 3'b001; // transition to state B
				else
					state <= 3'b000; // self-loop to stay in state A
				end
			end
			3'b001: begin // State B
				if (w) begin
					state <= 3'b010; // transition to state C
				else
					state <= 3'b100; // transition to state D
				end
			end
			3'b010: begin // State C
				if (w) begin
					state <= 3'b110; // transition to state E
				else
					state <= 3'b100; // transition to state D
				end
			end
			3'b011: begin // State D
				if (w) begin
					state <= 3'b110; // self-loop to stay in state D
				else
					state <= 3'b000; // transition to state A
				end
			end
			3'b100: begin // State E
				if (w) begin
					state <= 3'b100; // self-loop to stay in state E
				else
					state <= 3'b110; // transition to state D
				end
			end
			3'b101: begin // State F
				if (w) begin
					state <= 3'b011; // transition to state C
				else
					state <= 3'b110; // transition to state D
				end
			end
			default: state <= 3'b000; // default initial state: A
		endcase
	end
end

assign z = (state == 3'b100) || (state == 3'b101); // set z to 1 when state is E or F

endmodule
