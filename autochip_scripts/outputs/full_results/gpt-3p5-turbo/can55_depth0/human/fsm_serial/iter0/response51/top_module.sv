module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [2:0] state;
reg [7:0] count;
reg [7:0] data;
reg start_bit_detected;
reg stop_bit_detected;


always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b000;
		count <= 8'b00000000;
		data <= 8'b00000000;
		start_bit_detected <= 1'b0;
		stop_bit_detected <= 1'b0;
	end
	else begin
		case(state)
			3'b000: begin // IDLE state
				if (in == 1'b0) begin
					state <= 3'b001;
					start_bit_detected <= 1'b1;
				end
				else begin
					state <= 3'b000;
					start_bit_detected <= 1'b0;
					stop_bit_detected <= 1'b0;
				end
			end
			3'b001: begin // WAIT_DATA state
				count <= count + 1;
				data <= {data[6:0], in};
				if (count == 8) begin
					state <= 3'b010;
				end
				else begin
					state <= 3'b001;
				end
			end
			3'b010: begin // WAIT_STOP_BIT state
				count <= count + 1;
				if (count == 9 && in == 1'b1) begin
					state <= 3'b011;
					stop_bit_detected <= 1'b1;
				end
				else if (count == 9 && in == 1'b0) begin
					state <= 3'b000;
					start_bit_detected <= 1'b1;
				end
				else begin
					state <= 3'b010;
				end
			end
			3'b011: begin // BYTE_RECEIVED state
				state <= 3'b000;
				count <= 8'b00000000;
				done <= 1'b1;
			end
			default: state <= 3'b000;
		endcase
	end
end

endmodule
