module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

reg [7:0] shift_reg;
reg [2:0] state;
reg start_flag;
reg done_reg;

parameter IDLE = 0;
parameter RECEIVE = 1;
parameter PARITY_BIT = 2;
parameter STOP_BIT = 3;

always @(posedge clk) begin
	if (reset) begin
		state <= IDLE;
		shift_reg <= 8'b0;
		start_flag <= 0;
		done_reg <= 0;
	end else begin
		case(state)
			IDLE: begin
				if (in == 1) begin
					state <= RECEIVE;
					shift_reg <= 8'b0;
					start_flag <= 0;
				end
			end
			RECEIVE: begin
				shift_reg <= {in, shift_reg[7:1]};
				if (start_flag) begin
					state <= PARITY_BIT;
					start_flag <= 0;
				end
			end
			PARITY_BIT: begin
				if (start_flag) begin
					state <= STOP_BIT;
					start_flag <= 0;
				end
			end
			STOP_BIT: begin
				if (start_flag) begin
					state <= IDLE;
					done_reg <= 1;
					start_flag <= 0;
				end
			end
		endcase
	end
end

always @(posedge clk) begin
	if (reset) begin
		start_flag <= 0;
	end else begin
		if (state == IDLE && in == 0) begin
			start_flag <= 1;
		end else begin
			start_flag <= 0;
		end
	end
end

assign out_byte = shift_reg;
assign done = done_reg;

endmodule
