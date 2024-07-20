module top_module(
	input wire clk,
	input wire rst,
	output reg out,
	output reg valid);

	reg [1:0] state;
	reg [7:0] counter;

	// State definitions
	localparam IDLE = 2'b00;
	localparam WAIT = 2'b01;
	localparam PROCESS = 2'b10;
	localparam DONE = 2'b11;

	// Initial state
	always @(posedge rst)
		begin
			state <= IDLE;
			counter <= 8'd0;
			out <= 8'd0;
			valid <= 1'b0;
		end

	// FSM Implementation
	always @(posedge clk)
		begin
			case (state)
				IDLE:
					begin
						counter <= 8'd0;
						out <= 8'd0;
						valid <= 1'b0;
						if (rst)
							state <= IDLE;
						else
							state <= WAIT;
					end
				WAIT:
					begin
						counter <= counter + 1;
						out <= 8'd0;
						valid <= 1'b0;
						if (counter == 8'hFF)
							state <= PROCESS;
						else
							state <= WAIT;
					end
				PROCESS:
					begin
						out <= in;
						state <= DONE;
					end
				DONE:
					begin
						valid <= 1'b1;
						state <= IDLE;
					end
				default:
					state <= IDLE;
			endcase
		end
endmodule
