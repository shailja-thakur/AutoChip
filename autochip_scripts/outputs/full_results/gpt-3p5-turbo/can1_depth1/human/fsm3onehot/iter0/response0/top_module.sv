module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output out
);

	always @(*) begin
		case (state)
			4'b0001: begin // state A
				if (in == 1'b0) begin
					next_state = 4'b0001; // stay in A
					out = 1'b0;
				end else begin
					next_state = 4'b0010; // transition to B
					out = 1'b0;
				end
			end
			
			4'b0010: begin // state B
				if (in == 1'b0) begin
					next_state = 4'b0100; // transition to C
					out = 1'b0;
				end else begin
					next_state = 4'b0010; // stay in B
					out = 1'b0;
				end
			end
			
			4'b0100: begin // state C
				if (in == 1'b0) begin
					next_state = 4'b0001; // transition to A
					out = 1'b0;
				end else begin
					next_state = 4'b1000; // transition to D
					out = 1'b0;
				end
			end
			
			4'b1000: begin // state D
				if (in == 1'b0) begin
					next_state = 4'b0100; // transition to C
					out = 1'b1;
				end else begin
					next_state = 4'b0010; // transition to B
					out = 1'b0;
				end
			end
			
			default: begin // should not happen
				next_state = 4'bxxxx;
				out = 1'bx;
			end
		endcase
	end
	
endmodule
