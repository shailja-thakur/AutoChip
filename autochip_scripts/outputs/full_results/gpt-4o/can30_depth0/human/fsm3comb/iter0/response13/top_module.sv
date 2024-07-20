module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output reg out
);

	// Define state encoding
	localparam A = 2'b00;
	localparam B = 2'b01;
	localparam C = 2'b10;
	localparam D = 2'b11;

	always @(*) begin
		case (state)
			A: begin
				if (in == 1'b0) begin
					next_state = A;
				end else begin
					next_state = B;
				end
				out = 1'b0;
			end
			B: begin
				if (in == 1'b0) begin
					next_state = C;
				end else begin
					next_state = B;
				end
				out = 1'b0;
			end
			C: begin
				if (in == 1'b0) begin
					next_state = A;
				end else begin
					next_state = D;
				end
				out = 1'b0;
			end
			D: begin
				if (in == 1'b0) begin
					next_state = C;
				end else begin
					next_state = B;
				end
				out = 1'b1;
			end
			default: begin
				next_state = A;
				out = 1'b0;
			end
		endcase
	end

endmodule
