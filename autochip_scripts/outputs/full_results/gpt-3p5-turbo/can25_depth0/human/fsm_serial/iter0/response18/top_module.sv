module top_module (
	input clk,
	input in,
	input reset,
	output done
);


	reg [2:0] state;
	reg [7:0] data;
	reg valid;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 0;
		else
			case (state)
				0: begin
					// wait for start bit
					if (in == 0)
						state <= 1;
				end
				1: begin
					// receive data bits
					data[0] <= in;
					state <= 2;
				end
				2: begin
					data[1] <= in;
					state <= 3;
				end
				3: begin
					data[2] <= in;
					state <= 4;
				end
				4: begin
					data[3] <= in;
					state <= 5;
				end
				5: begin
					data[4] <= in;
					state <= 6;
				end
				6: begin
					data[5] <= in;
					state <= 7;
				end
				7: begin
					data[6] <= in;
					state <= 8;
				end
				8: begin
					data[7] <= in;
					state <= 9;
				end
				9: begin
					// check stop bit and finish receiving byte
					if (in == 1) begin
						state <= 0;
						valid <= 1;
					end else begin
						state <= 9;
						valid <= 0;
					end
				end
			endcase
	end
	
	assign done = valid;
	
endmodule
