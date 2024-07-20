module top_module(
	input wire clk,
	input wire reset,
	output wire data_out,
	output wire valid_out);

	reg [1:0] state;
	reg [7:0] counter;
	reg [7:0] data;

	// FSM states
	parameter IDLE = 2'b00;
	parameter WAIT = 2'b01;
	parameter PROCESS = 2'b10;
	parameter DONE = 2'b11;

	// Assign initial values to the signals
	assign data_out = data;
	assign valid_out = (state == DONE);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			counter <= 8'd0;
			data <= 8'd0;
		end else begin
			case (state)
				IDLE: begin
					counter <= 8'd0;
					data <= 8'd0;
					if (in) begin
						state <= WAIT;
					end
				end

				WAIT: begin
					counter <= counter + 8'd1;
					data <= 8'd0;
					if (counter == 8'd4) begin
						state <= PROCESS;
					end
				end

				PROCESS: begin
					data <= in;
					state <= DONE;
				end

				DONE: begin
					state <= IDLE;
				end
			endcase
		end
	end

endmodule
