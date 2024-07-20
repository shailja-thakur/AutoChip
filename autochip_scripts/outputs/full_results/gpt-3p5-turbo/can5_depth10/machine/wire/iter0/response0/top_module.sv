module top_module(
	input wire clk,
	input wire reset,
	output reg out);

	// Internal signals
	reg [1:0] state;
	reg [7:0] counter;
	reg [7:0] data;
	reg valid;

	// FSM states
	localparam IDLE = 2'b00;
	localparam WAIT = 2'b01;
	localparam PROCESS = 2'b10;
	localparam DONE = 2'b11;

	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			counter <= 0;
			data <= 0;
			valid <= 0;
		end else begin
			case (state)
				IDLE: begin
					counter <= 0;
					data <= 0;
					valid <= 0;
					state <= WAIT;
				end
				WAIT: begin
					counter <= counter + 1;
					data <= 0;
					valid <= 0;
					if (counter == 8'hFF) begin
						state <= PROCESS;
					end
				end
				PROCESS: begin
					data <= in;
					valid <= 1;
					state <= DONE;
				end
				DONE: begin
					valid <= 1;
					state <= IDLE;
				end
			endcase
		end
	end

	assign out = valid ? data : 0;

endmodule
