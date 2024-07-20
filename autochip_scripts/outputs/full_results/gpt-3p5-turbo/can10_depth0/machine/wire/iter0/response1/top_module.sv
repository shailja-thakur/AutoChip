module top_module(
	input wire clock,
	input wire reset,
	output wire data_output,
	output wire valid_output
	);
	
	reg [1:0] state;
	reg [3:0] counter;
	
	// Internal signals
	wire data;
	
	// Stimulus Generator Module
	stimulus_gen stimulus_gen_inst(
		.clock(clock),
		.reset(reset),
		.data(data),
		.valid(valid_output)
	);
	
	always @(posedge clock or posedge reset) begin
		if (reset)
			state <= 2'b00; // idle state
		else begin
			case (state)
				2'b00: begin // idle state
					counter <= 4'b0000;
					data_output <= 1'b0;
					
					if (in)
						state <= 2'b01; // wait state
					else
						state <= 2'b00;
				end
				
				2'b01: begin // wait state
					counter <= counter + 1;
					data_output <= 1'b0;
					
					if (counter == 4'b1010) // threshold
						state <= 2'b10; // process state
					else
						state <= 2'b01;
				end
				
				2'b10: begin // process state
					data_output <= data;
					state <= 2'b11; // done state
				end
				
				2'b11: begin // done state
					data_output <= data;
					valid_output <= 1'b1;
					state <= 2'b00; // idle state
				end
			endcase
		end
	end
	
endmodule
module stimulus_gen(
	input wire clock,
	input wire reset,
	output reg data,
	output reg valid
	);
	
	always @(posedge clock or posedge reset) begin
		if (reset) begin
			data <= 1'b0;
			valid <= 1'b0;
		end
		else begin
			if (data == 1'b1) begin
				data <= 1'b0;
				valid <= 1'b1;
			end
			else begin
				data <= 1'b1;
				valid <= 1'b0;
			end
		end
	end
	
endmodule
