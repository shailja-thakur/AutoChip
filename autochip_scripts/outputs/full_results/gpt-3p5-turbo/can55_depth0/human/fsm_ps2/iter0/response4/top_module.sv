module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

	reg [1:0] state;
	reg [7:0] input_buffer [2:0];

	always @(posedge clk or posedge reset)begin
		if(reset)begin
			state <= 2'b00;
			input_buffer <= 0;
			done <= 0;
		end else begin
			case(state)
				2'b00:begin
					if(in[3])begin
						input_buffer[0] <= in;
						state <= 2'b01;
					end
				end
				2'b01:begin
					if(in[3])begin
						input_buffer[1] <= in;
						state <= 2'b10;
					end else begin
						state <= 2'b00;
					end
				end
				2'b10:begin
					if(in[3])begin
						input_buffer[2] <= in;
						state <= 2'b11;
					end else begin
						state <= 2'b00;
					end
				end
				2'b11:begin
					done <= 1;
					state <= 2'b00;
				end
				default: state <= 2'b00;
			endcase
		end
	end

endmodule
