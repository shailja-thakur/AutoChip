module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [1:0] state;
reg [7:0] byte_count;
reg [7:0] message[2:0];

parameter IDLE = 0;
parameter WAIT_FOR_BYTE1 = 1;
parameter WAIT_FOR_BYTE2 = 2;
parameter WAIT_FOR_BYTE3 = 3;
parameter MESSAGE_RECEIVED = 4;

always @(posedge clk) begin
	if (reset) begin
		state <= IDLE;
		byte_count <= 0;
	end else begin
		case(state)
			IDLE: begin
				if (in[3] == 1) begin
					state <= WAIT_FOR_BYTE1;
					byte_count <= 1;
					message[0] <= in;
				end
			end
			WAIT_FOR_BYTE1: begin
				if (in[3] == 1) begin
					state <= WAIT_FOR_BYTE2;
					byte_count <= byte_count + 1;
					message[1] <= in;
				end
			end
			WAIT_FOR_BYTE2: begin
				if (in[3] == 1) begin
					state <= WAIT_FOR_BYTE3;
					byte_count <= byte_count + 1;
					message[2] <= in;
				end
			end
			WAIT_FOR_BYTE3: begin
				if (in[3] == 1) begin
					state <= MESSAGE_RECEIVED;
					byte_count <= byte_count + 1;
					message[0] <= in;
				end
			end
			MESSAGE_RECEIVED: begin
				state <= IDLE;
				byte_count <= 0;
				message[0] <= 0;
				message[1] <= 0;
				message[2] <= 0;
			end
		endcase
	end
end

assign done = (state == MESSAGE_RECEIVED);

endmodule
