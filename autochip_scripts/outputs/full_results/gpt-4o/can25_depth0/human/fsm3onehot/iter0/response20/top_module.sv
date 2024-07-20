module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output out
);

always @(*) begin
	case (state)
		4'b0001: begin // State A
			next_state = in ? 4'b0010 : 4'b0001; // A -> B if in=1, A -> A if in=0
		end
		4'b0010: begin // State B
			next_state = in ? 4'b0010 : 4'b0100; // B -> B if in=1, B -> C if in=0
		end
		4'b0100: begin // State C
			next_state = in ? 4'b1000 : 4'b0001; // C -> D if in=1, C -> A if in=0
		end
		4'b1000: begin // State D
			next_state = in ? 4'b0010 : 4'b0100; // D -> B if in=1, D -> C if in=0
		end
		default: begin
			next_state = 4'b0001; // Default to state A
		end
	endcase
end

assign out = (state == 4'b1000); // Output is 1 only in state D

endmodule
