module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

	always @(*) begin
		case (state)
			2'b00: begin // A
				if (in == 1'b0) begin
					next_state = 2'b00; // A
				end else begin
					next_state = 2'b01; // B
				end
				out = 1'b0;
			end
			
			2'b01: begin // B
				if (in == 1'b0) begin
					next_state = 2'b10; // C
				end else begin
					next_state = 2'b01; // B
				end
				out = 1'b0;
			end
			
			2'b10: begin // C
				if (in == 1'b0) begin
					next_state = 2'b00; // A
				end else begin
					next_state = 2'b11; // D
				end
				out = 1'b0;
			end
			
			2'b11: begin // D
				if (in == 1'b0) begin
					next_state = 2'b10; // C
				end else begin
					next_state = 2'b01; // B
				end
				out = 1'b1;
			end
		endcase
	end

endmodule
