module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);
	reg [2:0] state;
	reg [2:0] next_state;
	reg found_first_byte;
	reg received_second_byte;
	reg received_third_byte;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000;
			found_first_byte <= 1'b0;
			received_second_byte <= 1'b0;
			received_third_byte <= 1'b0;
		end else begin
			state <= next_state;
			found_first_byte <= found_first_byte;
			received_second_byte <= received_second_byte;
			received_third_byte <= received_third_byte;
		end
	end

	always @* begin
		case (state)
			3'b000: begin // Find first byte of message
				if (in[3] == 1'b1) begin
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

	always @(posedge clk) begin
		case (state)
			3'b000: begin // Find first byte of message
				found_first_byte <= in[3];
			end
			3'b001: begin // Receive second byte of message
				received_second_byte <= 1'b1;
			end
			3'b010: begin // Receive third byte of message
				received_third_byte <= 1'b1;
			end
			3'b011: begin // Wait one cycle after third byte to signal done
				received_second_byte <= 1'b0;
				received_third_byte <= 1'b0;
			end
		endcase
	end

	assign done = (found_first_byte && received_second_byte && received_third_byte);

endmodule
