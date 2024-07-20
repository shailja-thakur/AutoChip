module top_module(
	input wire clk,
	input wire reset,
	output reg data_out,
	output reg valid_out);

	reg [1:0] state;
	reg [7:0] counter;

	// States
	parameter idle = 2'd0;
	parameter wait = 2'd1;
	parameter process = 2'd2;
	parameter done = 2'd3;

	// Initial state assignment
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= idle;
			counter <= 8'd0;
			data_out <= 1'b0;
			valid_out <= 1'b0;
		end else begin
			case(state)
				idle: begin
					counter <= 8'd0;
					data_out <= 1'b0;
					valid_out <= 1'b0;
					if (in) begin
						state <= wait;
					end
				end
				
				wait: begin
					counter <= counter + 1;
					data_out <= 1'b0;
					valid_out <= 1'b0;
					if (counter == 8'd10) begin
						state <= process;
					end
				end
				
				process: begin
					data_out <= in;
					valid_out <= 1'b1;
					state <= done;
				end
				
				done: begin
					data_out <= in;
					valid_out <= 1'b1;
					state <= idle;
				end
			endcase
		end
	end
endmodule
