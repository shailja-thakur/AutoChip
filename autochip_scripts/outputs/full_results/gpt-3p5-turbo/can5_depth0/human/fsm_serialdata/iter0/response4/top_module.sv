module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

	// State parameter
	parameter START = 2'b00;
	parameter RECEIVE = 2'b01;
	parameter STOP = 2'b10;

	// Internal signals
	reg [7:0] data_byte;
	reg [7:0] shift_reg;
	reg [1:0] state;
	reg done_next;

	// FSM
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= START;
			shift_reg <= 8'b0;
			data_byte <= 8'b0;
			done_next <= 1'b0;
		end else begin
			case (state)
				START: begin
					if (in == 1'b0) begin
						shift_reg <= {shift_reg[6:0], in};
						state <= RECEIVE;
					end
				end
				RECEIVE: begin
					shift_reg <= {shift_reg[6:0], in};
					
					if (shift_reg[7:0] === 8'b1) begin
						data_byte <= shift_reg[6:0];
						state <= STOP;
					end
				end
				STOP: begin
					if (in == 1'b1 && shift_reg[7:0] === 8'b1) begin
						done_next <= 1'b1;
						state <= START;
					end else begin
						state <= STOP;
					end
				end
			endcase
		end
	end

	// Output
	assign out_byte = data_byte;
	assign done = done_next;

endmodule
