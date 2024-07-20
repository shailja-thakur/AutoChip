module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

// Define states
parameter S_IDLE = 3'b000;
parameter S_BYTE1 = 3'b001;
parameter S_BYTE2 = 3'b010;
parameter S_BYTE3 = 3'b011;

// Define signals
reg [2:0] state;
reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;
reg [23:0] message;

// State machine
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= S_IDLE;
		message <= 0;
	end else begin
		case (state)
			S_IDLE: begin
				if (in[3] == 1'b1) begin
					state <= S_BYTE1;
					byte1 <= in;
				end
			end
			S_BYTE1: begin
				state <= S_BYTE2;
				byte2 <= in;
			end
			S_BYTE2: begin
				state <= S_BYTE3;
				byte3 <= in;
			end
			S_BYTE3: begin
				state <= S_IDLE;
				message <= {byte1, byte2, byte3};
			end
		endcase
	end
end

// Output logic
always @(posedge clk or posedge reset) begin
	if (reset) begin
		done <= 1'b0;
		out_bytes <= 0;
	end else begin
		if (state == S_BYTE3) begin
			done <= 1'b1;
			out_bytes <= message;
		end else begin
			done <= 1'b0;
			out_bytes <= 0;
		end
	end
end

endmodule
