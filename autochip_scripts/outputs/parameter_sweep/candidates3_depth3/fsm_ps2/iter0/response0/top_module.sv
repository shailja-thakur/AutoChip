module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [1:0] state;
reg done;
reg [2:0] count;
reg last_in3;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b00;
		done <= 0;
		count <= 3'b000;
		last_in3 <= 1'b0;
	end else begin
		case (state)
			2'b00: begin
				if (in[3]) begin
					state <= 2'b01;
					done <= 0;
					count <= 3'b001;
					last_in3 <= in[3];
				end else begin
					state <= 2'b00;
					done <= 0;
					count <= 3'b000;
					last_in3 <= in[3];
				end
			end
			2'b01: begin
				if (count == 3'b111) begin
					state <= 2'b10;
					done <= 1;
				end else if (in[3]) begin
					state <= 2'b00;
					done <= 0;
					count <= count + 1;
					last_in3 <= in[3];
				end else begin
					state <= 2'b01;
					done <= 0;
					count <= count + 1;
					last_in3 <= in[3];
				end
			end
			2'b10: begin
				state <= 2'b00;
				done <= 0;
				count <= 3'b000;
				last_in3 <= in[3];
			end
		endcase
	end
end

endmodule
