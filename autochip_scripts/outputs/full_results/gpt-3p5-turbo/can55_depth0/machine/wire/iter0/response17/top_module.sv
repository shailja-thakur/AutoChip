module top_module(
	input clock,
	input reset,
	output reg out,
	output reg valid);
	
	reg [1:0] state;
	reg [3:0] counter;
	reg [3:0] threshold = 4'd10;
	reg [7:0] data;

	always @(posedge clock or posedge reset) begin
		if (reset)
			state <= 2'd0;
		else begin
			case(state)
				0: begin // idle state
					counter <= 4'd0;
					data <= 8'd0;
					state <= 2'd1;
				end
				
				1: begin // wait state
					counter <= counter + 1'd1;
					data <= 8'd0;
					
					if (counter >= threshold)
						state <= 2'd2;
				end
				
				2: begin // process state
					data <= in;
					state <= 2'd3;
				end
				
				3: begin // done state
					valid <= 1'b1;
					state <= 2'd0;
				end
			endcase
		end
	end

	assign out = data;
endmodule
