module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

	// State machine states
	localparam A = 2'b00;
	localparam B = 2'b01;
	localparam C = 2'b10;
	localparam D = 2'b11;

	always_comb begin
		case (state)
			A: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end

			B: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = C;
				end
			end

			C: begin
				if (in) begin
					next_state = D;
				end else begin
					next_state = A;
				end
			end

			D: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = C;
				end
			end
		endcase
	end

	assign out = (state == D) ? 1'b1 : 1'b0;

endmodule
