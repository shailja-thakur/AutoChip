module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);
	reg [2:0] state;
	reg [2:0] next_state;
	reg [7:0] prev_in;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000;
			prev_in <= 8'b0;
		end else begin
			state <= next_state;
			prev_in <= in;
		end
	end

	always @* begin
		case (state)
			3'b000: begin // Find first byte of message
				if (prev_in[3] == 1'b1 && in[3] == 1'b1) begin
					next_state = 3'b001;
				end else begin
					next_state = 3'b000;
				end
			end
			3'b001: begin // Receive second byte of message
				next_state = 3'b010;
			end
			3'b010: begin // Receive third byte of message
				next_state = 3'b011;
			end
			3'b011: begin // Wait one cycle after third byte to signal done
				next_state = 3'b000;
			end
			default: begin
				next_state = 3'b000;
			end
		endcase
	end

	assign done = (state == 3'b011);

endmodule
