module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [3:0] state;
reg start_detected;
reg [7:0] data;
reg stop_detected;
	
wire idle = ~in;
wire start = (state == 0) & in;
wire data_bit = (state > 0) & (state < 9);
wire stop = (state == 9) & ~in;
	
assign done = state == 10;
	
always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 0;
	else begin
		case (state)
			0: begin // idle state
				state <= start ? 1 : 0;
			end
			
			1 to 8: begin // data states
				state <= data_bit ? state + 1 : 0;
				data <= data << 1 | in;
			end
			
			9: begin // stop state
				state <= stop ? 10 : 0;
				stop_detected <= stop;
			end
			
			10: begin // done state
				state <= idle ? 0 : 10;
				start_detected <= !idle;
				stop_detected <= 0;
				data <= 0;
			end
		endcase
	end
end

endmodule
