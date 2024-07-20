module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

reg [3:0] state;
reg [7:0] data_byte;
reg start_bit_found;
reg [2:0] bit_count;

always @(posedge clk or posedge reset) begin
	if(reset == 1) begin
		state <= 0;
		out_byte <= 0;
		done <= 0;
		start_bit_found <= 0;
		data_byte <= 0;
		bit_count <= 0;
	end else begin
		case(state)
			0: begin // IDLE state
				if(in == 1) begin
					state <= 0;
				end else begin
					state <= 1;
					start_bit_found <= 0;
					data_byte <= 0;
					bit_count <= 0;
				end
			end
			1: begin // START state
				if(in == 0) begin
					state <= 1;
				end else begin
					state <= 2;
				end
			end
			2: begin // DATA state
				if(bit_count < 8) begin
					data_byte <= {in, data_byte[7:1]};
					bit_count <= bit_count + 1;
					state <= 2;
				end else begin
					state <= 3;
				end
			end
			3: begin // STOP state
				if(in == 1) begin
					state <= 4;
				end else begin
					state <= 1;
					start_bit_found <= 0;
					data_byte <= 0;
					bit_count <= 0;
				end
			end
			4: begin // DONE state
				if(in == 1) begin
					state <= 4;
				end else begin
					state <= 0;
					done <= 1;
					out_byte <= data_byte;
				end
			end
		endcase
	end
end

endmodule
