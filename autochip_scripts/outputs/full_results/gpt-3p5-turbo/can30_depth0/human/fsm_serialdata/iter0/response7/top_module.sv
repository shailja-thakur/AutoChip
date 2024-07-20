module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

reg [3:0] state;
reg [7:0] data_byte;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		data_byte <= 8'b0;
		out_byte <= 8'b0;
		done <= 0;
	end
	else begin
		case (state)
			0: begin // Idle state
				if (in == 1'b0) begin
					state <= 1; // Move to Start bit state
					data_byte <= 8'b0;
				end
			end
			
			1: begin // Start bit state
				if (in == 1'b0) begin
					state <= 2; // Move to Data state
				end
				else begin
					state <= 0; // Stay in Idle state
				end
			end
			
			2: begin // Data state
				if (in == 1'b1) begin
					state <= 3; // Move to Stop bit state
				end
				else begin
					data_byte <= {data_byte[6:0], in}; // Shift input bit into data_byte
				end
			end
			
			3: begin // Stop bit state
				if (in == 1'b1) begin
					out_byte <= data_byte; // Output valid byte
					done <= 1; // Assert done
					state <= 0; // Move back to Idle state
				end
				else begin
					state <= 0; // Move back to Idle state if stop bit is not found
				end
			end
		endcase
	end
end

endmodule
