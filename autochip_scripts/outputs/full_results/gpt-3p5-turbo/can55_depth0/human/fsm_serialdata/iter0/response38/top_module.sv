module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

reg [2:0] state;
reg [7:0] data;
reg [2:0] counter;

// States
parameter IDLE = 3'b000;
parameter START_BIT = 3'b001;
parameter DATA_BITS = 3'b010;
parameter STOP_BIT = 3'b011;
parameter DONE = 3'b100;

// Reset and initial values
always @(posedge clk)
begin
	if (reset)
		begin
			state <= IDLE;
			data <= 8'b0;
			counter <= 3'b0;
			done <= 1'b0;
		end
	else
		begin
			case (state)
				IDLE:
					begin
						if (in == 1'b0)
							state <= START_BIT;
					end
				
				START_BIT:
					begin
						state <= DATA_BITS;
						data <= in;
						counter <= 3'b1;
					end
				
				DATA_BITS:
					begin
						if (counter < 3)
							begin
								data <= {data[6:0], in};
								counter <= counter + 3'b1;
							end
						else
							state <= STOP_BIT;
					end
				
				STOP_BIT:
					begin
						if (in == 1'b1)
							begin
								out_byte <= data;
								done <= 1'b1;
								state <= DONE;
							end
						else
							state <= IDLE;
					end
				
				DONE:
					begin
						if (in == 1'b1)
							state <= IDLE;
					end
			endcase
		end
end

endmodule
