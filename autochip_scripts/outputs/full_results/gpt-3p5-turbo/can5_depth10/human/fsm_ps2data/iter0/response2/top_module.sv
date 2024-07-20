module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);
	// Internal signals
	reg [23:0] message;
	reg [1:0] state;
	
	// State definitions
	parameter IDLE = 2'b00;
	parameter SEARCH = 2'b01;
	parameter DONE = 2'b10;
	
	// Sequential logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			message <= 0;
		end
		else begin
			case (state)
				IDLE: begin
					if (in[3]) begin
						state <= SEARCH;
						message <= in;
					end
				end
				SEARCH: begin
					if (in[3]) begin
						state <= SEARCH;
						message <= {message[15:0], in};
					end
					else begin
						state <= DONE;
						message <= {message[15:0], in};
					end
				end
				DONE: begin
					state <= IDLE;
				end
				default: begin
					state <= IDLE;
				end
			endcase
		end
	end
	
	// Combinational logic
	assign out_bytes = (state == DONE) ? message : 0;
	assign done = (state == DONE) ? 1 : 0;
	
endmodule
