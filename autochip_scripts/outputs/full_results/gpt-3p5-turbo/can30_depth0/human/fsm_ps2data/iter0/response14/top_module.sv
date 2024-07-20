module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [2:0] state;
reg [23:0] temp_out_bytes;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		temp_out_bytes <= 0;
	end else begin
		case(state)
			0: begin
				if (in[3] == 1) begin
					state <= 1;
				end
			end
			1: begin
				temp_out_bytes <= {in, temp_out_bytes[23:8]};
				state <= 2;
			end
			2: begin
				temp_out_bytes <= {temp_out_bytes[15:0], in};
				state <= 3;
			end
			3: begin
				temp_out_bytes <= {in, temp_out_bytes[23:8]};
				state <= 4;
			end
			4: begin
				temp_out_bytes <= {temp_out_bytes[15:0], in};
				state <= 5;
				done <= 1;
			end
			5: begin
				done <= 0;
				state <= 0;
			end
		endcase
	end
end

assign out_bytes = temp_out_bytes;

endmodule
