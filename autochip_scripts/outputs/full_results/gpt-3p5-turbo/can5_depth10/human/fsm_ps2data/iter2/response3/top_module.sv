module top_module(
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [23:0] message;
	reg [1:0] state;
	reg [2:0] counter;
	reg sync_reset;
	
	parameter IDLE = 2'b00;
	parameter SEARCH = 2'b01;
	parameter DONE = 2'b10;
	
	assign out_bytes = (state == DONE && counter == 3) ? message : 0;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			message <= 24'b0;
			counter <= 3'b0;
			sync_reset <= 1;
		end
		else begin
			sync_reset <= 0;
			case (state)
				IDLE: begin
					if (in[3]) begin
						state <= SEARCH;
						message <= {in, message[23:8]};
						counter <= 3'b1;
					end
				end
				SEARCH: begin
					if (in[3]) begin
						state <= SEARCH;
						message <= {in, message[23:8]};
						counter <= counter + 1;
					end
					else if (counter == 3'b2) begin
						state <= DONE;
						message <= {in, message[23:8]};
						counter <= counter + 1;
					end
				end
				DONE: begin
					state <= IDLE;
					counter <= 3'b0;
				end
			endcase
		end
	end
	
	always @(posedge clk) begin
		done <= (state == DONE && counter == 3);
	end
endmodule
