module top_module(
	input wire clk,
	input wire rst,
	output wire data_out,
	output wire valid_out);

	// Internal signals
	reg [1:0] state;
	reg [7:0] counter;
	reg [7:0] data;

	// FSM states
	localparam IDLE = 2'b00;
	localparam WAIT = 2'b01;
	localparam PROCESS = 2'b10;
	localparam DONE = 2'b11;

	// Initial state assignment
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			state <= IDLE;
			counter <= 0;
			data <= 0;
		end else begin
			case(state)
				IDLE: begin
					counter <= 0;
					data <= 0;
					
					if (in) begin
						state <= WAIT;
					end
				end
				
				WAIT: begin
					counter <= counter + 1;
					data <= 0;
					
					if (counter >= 10) begin // Adjust threshold as needed
						state <= PROCESS;
					end
				end
				
				PROCESS: begin
					data <= in;
					
					state <= DONE;
				end
				
				DONE: begin
					data <= in;
					
					state <= IDLE;
				end
			endcase
		end
	end

	// Output assignments
	assign out = data;
	assign valid_out = (state == DONE);

endmodule
