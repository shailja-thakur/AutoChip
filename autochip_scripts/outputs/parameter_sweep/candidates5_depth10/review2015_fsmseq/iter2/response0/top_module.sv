module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;

	reg [3:0] input_buffer;
	wire seq_found;

	assign seq_found = (input_buffer == 4'b1101);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
			start_shifting <= 0;
		end else begin
			case (state)
				0: begin
					if (data) begin
						state <= 1;
						input_buffer <= {input_buffer[2:0], data};
					end
				end
				1: begin
					if (data) begin
						state <= 2;
						input_buffer <= {input_buffer[2:0], data};
					end else begin
						state <= 0;
						input_buffer <= {input_buffer[2:0], data};
					end
				end
				2: begin
					if (data) begin
						state <= 3;
						input_buffer <= {input_buffer[2:0], data};
					end else begin
						state <= 0;
						input_buffer <= {input_buffer[2:0], data};
					end
				end
				3: begin
					if (data) begin
						state <= 4;
						input_buffer <= {input_buffer[2:0], data};
					end else begin
						state <= 0;
						input_buffer <= {input_buffer[2:0], data};
					end
				end
				4: begin
					if (data) begin
						state <= 4;
						input_buffer <= {input_buffer[2:0], data};
					end else begin
						state <= 0;
						input_buffer <= {input_buffer[2:0], data};
						start_shifting <= 1;
					end
				end
			endcase
		end
	end

endmodule
