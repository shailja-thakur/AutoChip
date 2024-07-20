module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [3:0] state;

always@(posedge clk or posedge reset) begin
	if(reset) begin
		state <= 4'b0000;
	end else begin
		case(state)
			4'b0000: begin // idle state
				if(in == 1'b0) begin
					state <= 4'b0001; // transition to start bit state
				end
			end
			
			4'b0001: begin // start bit state
				if(in == 1'b0) begin
					state <= 4'b0010; // transition to data bit state
				end else begin
					state <= 4'b0000; // transition back to idle state
				end
			end
			
			4'b0010: begin // data bit state
				state <= 4'b0011; // transition to next data bit state
				
				// store the received data bit here
				
				// check if it's the final data bit
				if(...) begin
					state <= 4'b0100; // transition to stop bit state
				end
			end
			
			4'b0011: begin // next data bit state
				state <= 4'b0010; // transition back to the previous data bit state
				
				// store the received data bit here
				
				// check if it's the final data bit
				if(...) begin
					state <= 4'b0100; // transition to stop bit state
				end
			end
			
			4'b0100: begin // stop bit state
				if(in == 1'b1) begin
					state <= 4'b0101; // transition to done state
				end else begin
					state <= 4'b0000; // transition back to idle state
				end
			end
			
			4'b0101: begin // done state
				state <= 4'b0100; // transition back to stop bit state
			end
		endcase
	end
end

assign done = (state == 4'b0101);

endmodule
