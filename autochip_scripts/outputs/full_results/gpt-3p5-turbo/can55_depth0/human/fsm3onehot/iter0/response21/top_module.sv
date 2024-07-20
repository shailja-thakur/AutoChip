module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output out
);

	always @(*) begin
		case (state)
			4'b0001: begin
				if (in) begin
					next_state = 4'b0010;
					out = 1'b0;
				end
				else begin
					next_state = 4'b0001;
					out = 1'b0;
				end
			end
			4'b0010: begin
				if (in) begin
					next_state = 4'b0010;
					out = 1'b0;
				end
				else begin
					next_state = 4'b0100;
					out = 1'b0;
				end
			end
			4'b0100: begin
				if (in) begin
					next_state = 4'b0001;
					out = 1'b0;
				end
				else begin
					next_state = 4'b1000;
					out = 1'b0;
				end
			end
			4'b1000: begin
				if (in) begin
					next_state = 4'b0100;
					out = 1'b1;
				end
				else begin
					next_state = 4'b0010;
					out = 1'b0;
				end
			end
			default: begin
				next_state = 4'bXXXX;
				out = 1'bx;
			end
		endcase
	end

endmodule
