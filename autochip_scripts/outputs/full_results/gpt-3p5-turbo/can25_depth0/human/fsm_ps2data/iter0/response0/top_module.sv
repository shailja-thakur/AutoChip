module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [1:0] state;
reg [7:0] byte_count;
reg [23:0] message_buffer;
reg [7:0] current_byte;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b00;
        byte_count <= 0;
	end else begin
		case (state)
			0: begin // Discard bytes until in[3]=1
				if (in[3] == 1) begin
					state <= 2'b01;
					current_byte <= in;
				end else begin
					state <= 2'b00;
				end
			end
			1: begin // Received byte 1, store in buffer
				if (byte_count == 2) begin
					message_buffer[23:16] <= in;
					byte_count <= byte_count + 1;
					state <= 2'b10;
				end else begin
					message_buffer[15:8] <= in;
					byte_count <= byte_count + 1;
				end
			end
			2: begin // Received byte 2, store in buffer
				message_buffer[7:0] <= in;
				byte_count <= byte_count + 1;
				state <= 2'b11;
			end
			3: begin // Received byte 3, complete message
				out_bytes <= message_buffer;
				done <= 1;
				byte_count <= 0;
				state <= 2'b00;
			end
		endcase
	end
end

endmodule
