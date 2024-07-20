module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

reg [3:0] state;
reg start_bit_detected;
reg [7:0] data;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		start_bit_detected <= 0;
		data <= 0;
	end else begin
		case (state)
			0: begin
				if (in == 1'b0) begin
					state <= 1;
				end
			end
			1: begin
				start_bit_detected <= 1;
				state <= 2;
			end
			2: begin
				data <= {in, data[7:1]};
				state <= 3;
			end
			3: begin
				state <= 4;
			end
			4: begin
				if (in == 1'b1) begin
					state <= 5;
				end
			end
			5: begin
				if (start_bit_detected == 1) begin
					out_byte <= data;
					start_bit_detected <= 0;
					state <= 0;	
				end
			end
			default: state <= 0;
		endcase
	end
end

assign done = (state == 5);

endmodule
