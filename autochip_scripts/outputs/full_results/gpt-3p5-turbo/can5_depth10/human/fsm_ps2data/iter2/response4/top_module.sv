module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	// Internal signals
	reg [23:0] message;
	reg [1:0] state;
	reg [2:0] counter;
	reg sync_reset;
	
	// State definitions
	parameter IDLE = 2'b00;
	parameter SEARCH = 2'b01;
	parameter DONE = 2'b10;
	
	// Sequential logic
	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			message <= 0;
			counter <= 0;
			sync_reset <= 0;
			done <= 0;
		end
		else begin
			case (state)
				IDLE: begin
					if (in[3]) begin
						state <= SEARCH;
						message <= in;
						counter <= 1;
					end
				end
				SEARCH: begin
					if (in[3]) begin
						state <= SEARCH;
						message <= {message[15:0], in};
						counter <= counter + 1;
					end
					else begin
						state <= DONE;
						message <= {message[15:0], in};
						counter <= counter + 1;
					end
				end
				DONE: begin
					state <= IDLE;
					counter <= 0;
					sync_reset <= 1;
					done <= 1;
				end
				default: begin
					state <= IDLE;
					counter <= 0;
					sync_reset <= 0;
					done <= 0;
				end
			endcase
		end
	end
	
	// Combinational logic
	// assign out_bytes = (state == DONE && counter == 3) ? message : 0;
	// assign done = (state == DONE && counter == 3) ? 1 : 0;

	// Synchronous reset
	always @(posedge clk) begin
		if (sync_reset) begin
			sync_reset <= 0;
		end
	end
	
	// Output logic
	always @(posedge clk) begin
		if (state == DONE && counter == 3) begin
			out_bytes <= message;
		end
		else begin
			out_bytes <= 0;
		end
	end
endmodule
