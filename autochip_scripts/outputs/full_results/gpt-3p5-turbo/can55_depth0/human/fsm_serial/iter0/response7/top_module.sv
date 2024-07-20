module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [2:0] state;
reg [7:0] data;
reg prev_in;
reg done;

// Define states
parameter START = 3'b000;
parameter RECEIVE = 3'b001;
parameter STOP = 3'b010;

always @(posedge clk) begin
	if (reset) begin
		state <= START;
		data <= 8'b0; // Initializing data to 0
		done <= 1'b0; // Initializing done to 0
	end else begin
		case (state)
			START: begin
				if (in == 1'b0 && prev_in == 1'b1) begin // Detect start bit
					state <= RECEIVE;
					data <= 8'b0;
				end
			end
			
			RECEIVE: begin
				data <= {data[6:0], in}; // Shift in the received bit
				
				if (data == 8'b11111111) begin // Verify stop bit (00000001)
					state <= STOP;
				end
			end
			
			STOP: begin
				if (in == 1'b1 && prev_in == 1'b1) begin // Detect stop bit
					state <= START;
					done <= 1'b1; // Set done to 1, indicating byte reception is complete
				end
			end
		endcase
	end
	prev_in <= in;
end

endmodule
