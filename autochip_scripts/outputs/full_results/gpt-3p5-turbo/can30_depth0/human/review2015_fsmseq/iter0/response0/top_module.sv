module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

// Define states of the finite-state machine
parameter IDLE = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
parameter S3 = 2'b11;

// Define signals
reg [1:0] state;
reg start_shifting;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		start_shifting <= 0;
	end else begin
		case (state)
			IDLE: begin
				if (data == 1)
					state <= S1;
				end
			S1: begin
				if (data == 1)
					state <= S2;
				else
					state <= IDLE;
				end
			S2: begin
				if (data == 0)
					state <= S3;
				else
					state <= IDLE;
				end
			S3: begin
				if (data == 1) begin
					state <= S1;
					start_shifting <= 1;
				end else
					state <= S2;
				end
		endcase
	end
end

endmodule
