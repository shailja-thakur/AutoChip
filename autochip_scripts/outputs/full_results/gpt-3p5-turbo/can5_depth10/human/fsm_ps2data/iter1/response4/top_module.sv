module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);
	// Internal signals
	reg [23:0] message;
	reg [2:0] state;
	
	// State definitions
	parameter IDLE = 3'b000;
	parameter SEARCH = 3'b001;
	parameter DONE = 3'b010;
	
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
						message <= {in, message[23:8]};
					end
				end
				SEARCH: begin
					if (in[3]) begin
						state <= SEARCH;
						message <= {in, message[23:8]};
					end
					else begin
						state <= DONE;
						message <= {in, message[23:8]};
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
	assign out_bytes = (state == DONE) ? message : 24'b0;
	assign done = (state == DONE) ? 1'b1 : 1'b0;
	
endmodule
