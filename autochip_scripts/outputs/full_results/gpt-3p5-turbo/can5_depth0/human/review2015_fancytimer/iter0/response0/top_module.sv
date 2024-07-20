module top_module(
	input wire clk,
	input wire reset,
	input wire data,
	output wire [3:0] count,
	output reg counting,
	output reg done,
	input wire ack );

	reg [3:0] delay;
	reg [2:0] state;
	reg found_sequence;
	reg done_ack;

	always @(posedge clk) begin
		if (reset) begin
			state <= 0;
			counting <= 0;
			done <= 0;
			delay <= 0;
			found_sequence <= 0;
		end else begin
			case(state)
				0: begin
					if(data == 1'b1)
						state <= 1;
					else
						state <= 0;
				end
				1: begin
					if(data == 1'b1)
						state <= 2;
					else
						state <= 0;
				end
				2: begin
					if(data == 1'b0)
						state <= 3;
					else
						state <= 0;
				end
				3: begin
					if(data == 1'b1)
						begin
							state <= 4;
							found_sequence <= 1;
						end
					else
						state <= 0;
				end
				4: begin
					delay <= data;
					if(found_sequence)
						state <= 5;
					else
						state <= 0;
				end
				5: begin
					counting <= 1;
					state <= 6;
				end
				6: begin
					if(count == (delay + 1) * 1000) begin
						state <= 7;
						done <= 1;
					end else
						state <= 6;
				end
				7: begin
					if(ack == 1'b1)
						state <= 0;
					else
						state <= 7;
				end
				default: state <= 0;
			endcase
		end
	end

	always @(posedge clk) begin
		if (reset)
			count <= 0;
		else if (state == 5)
			count <= count + 1;
		else
			count <= 0;
	end

	always @(posedge clk) begin
		if (reset)
			done_ack <= 0;
		else if (state == 7)
			done_ack <= ack;
		else
			done_ack <= 0;
	end

	always @(posedge clk) begin
		if (reset)
			done <= 0;
		else
			done <= done_ack;
	end

endmodule
