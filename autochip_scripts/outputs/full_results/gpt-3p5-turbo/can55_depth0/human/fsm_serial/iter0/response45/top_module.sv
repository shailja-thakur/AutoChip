module top_module (
	input clk,
	input in,
	input reset,
	output done
);
	// States
	parameter IDLE = 2'b00;
	parameter START = 2'b01;
	parameter DATA = 2'b10;
	parameter STOP = 2'b11;

	reg [1:0] state, next_state;

	// Counter to wait for 8 data bits
	reg [2:0] count;

	// Flip flop to store the received byte
	reg [7:0] byte;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			count <= 3'd0;
			byte <= 8'd0;
			done <= 1'b0;
		end else begin
			state <= next_state;
			count <= count + 1;

			case (state)
				IDLE: begin
					if (in == 1'b0) begin
						next_state <= START;
						count <= 3'd0;
						byte <= 8'd0;
					end else begin
						next_state <= IDLE;
					end
				end

				START: begin
					if (count == 3'd7) begin
						next_state <= DATA;
						byte <= {in, byte[7:1]};
					end else begin
						next_state <= START;
						byte <= {in, byte[7:1]};
					end
				end

				DATA: begin
					if (count == 3'd0) begin
						next_state <= STOP;
						byte <= {in, byte[7:1]};
					end else if (count < 3'd7) begin
						next_state <= DATA;
						byte <= {in, byte[7:1]};
					end else begin
						next_state <= IDLE;
					end
				end

				STOP: begin
					if (count == 3'd7) begin
						if (in == 1'b1) begin
							next_state <= IDLE;
							done <= 1'b1;
						end else begin
							next_state <= STOP;
							byte <= {in, byte[7:1]};
						end
					end else begin
						if (in == 1'b1) begin
							next_state <= IDLE;
						end else begin
							next_state <= STOP;
							byte <= {in, byte[7:1]};
						end
					end
				end

				default: next_state <= IDLE;
			endcase
		end
	end
endmodule
