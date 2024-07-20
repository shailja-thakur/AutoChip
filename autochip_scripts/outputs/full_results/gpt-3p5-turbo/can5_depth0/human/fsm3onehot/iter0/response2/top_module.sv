module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

	always @(*) begin
		case(state)
			4'b0001: begin // state A
				if(in) begin
					next_state = 4'b0010; // B
					out = 1'b0;
				end else begin
					next_state = 4'b0001; // A
					out = 1'b0;
				end
			end

			4'b0010: begin // state B
				if(in) begin
					next_state = 4'b0010; // B
					out = 1'b0;
				end else begin
					next_state = 4'b0100; // C
					out = 1'b0;
				end
			end

			4'b0100: begin // state C
				if(in) begin
					next_state = 4'b0001; // A
					out = 1'b0;
				end else begin
					next_state = 4'b1000; // D
					out = 1'b0;
				end
			end

			4'b1000: begin // state D
				if(in) begin
					next_state = 4'b0100; // C
					out = 1'b1;
				end else begin
					next_state = 4'b0010; // B
					out = 1'b0;
				end
			end

			default: begin
				next_state = 4'bxxxx;
				out = 1'bx;
			end
		endcase
	end

endmodule
