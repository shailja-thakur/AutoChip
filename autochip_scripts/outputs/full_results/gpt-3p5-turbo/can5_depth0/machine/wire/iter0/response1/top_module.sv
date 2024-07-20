module top_module(
	input wire clock,
	input wire reset,
	output wire data_output,
	output wire valid_output);

	reg [1:0] state;
	reg [7:0] counter;
	wire [7:0] data;
	
	// Stimulus_gen module instantiation
	stimulus_gen stimulus_gen_inst (
		.clock(clock),
		.reset(reset),
		.data(data),
		.valid(valid_output)
	);

	always @(posedge clock or posedge reset) begin
		if(reset) begin
			state <= 2'b00;  // idle state
			counter <= 8'b0;
			data_output <= 8'b0;
		end else begin
			case(state)
				2'b00: begin  // idle state
					counter <= 8'b0;
					data_output <= 8'b0;
					if(in) begin
						state <= 2'b01;  // wait state
					end
				end
				2'b01: begin  // wait state
					counter <= counter + 1;
					data_output <= 8'b0;
					if(counter >= 8'd10) begin
						state <= 2'b10;  // process state
					end
				end
				2'b10: begin  // process state
					data_output <= data;
					state <= 2'b11;  // done state
				end
				2'b11: begin  // done state
					data_output <= data;
					valid_output <= 1'b1;
					state <= 2'b00;  // idle state
				end
			endcase
		end
	end

endmodule
