module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [3:0] state;
reg [7:0] data;

always @(posedge clk or posedge reset)
begin
	if (reset)
	begin
		state <= 0;
		data <= 0;
	end
	else
	begin
		case (state)
			0: // Idle state, waiting for start bit
				begin
					if (in == 0)
					begin
						state <= 1; // Move to data state
						data <= 0;
					end
				end
			1: // Data state, receiving 8 data bits
				begin
					data <= {in, data[7:1]}; // Shift in received bit
					state <= (data[7:0] == 8'b11111110) ? 2 : 1; // Move to stop bit state if all data bits received
				end
			2: // Stop bit state, waiting for stop bit
				begin
					if (in)
					begin
						state <= 3; // Move to done state
						done <= 1;
					end
					else
					begin
						state <= 0; // Move back to idle state if stop bit incorrect
					end
				end
			3: // Done state, waiting for next start bit
				begin
					if (in == 0)
					begin
						state <= 1; // Move back to data state
						done <= 0;
					end
				end
			default: state <= 0;
		endcase
	end
end

endmodule
