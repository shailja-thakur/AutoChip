module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [2:0] state;
reg [7:0] prev_byte;

always @(posedge clk) begin
	if (reset) begin
		state <= 0;
		prev_byte <= 0;
		done <= 0;
	end else begin
		case (state)
			0: begin
				   if (in[3] == 1) begin
					   prev_byte <= in;
					   state <= 1;
				   end else begin
					   prev_byte <= in;
					   state <= 0;
				   end
			   end
			1: begin
				   if (in[3] == 1) begin
					   prev_byte <= in;
					   state <= 1;
				   end else begin
					   prev_byte <= in;
					   state <= 2;
				   end
			   end
			2: begin
				   if (in[3] == 1) begin
					   prev_byte <= in;
					   state <= 1;
					   done <= 1;
				   end else begin
					   prev_byte <= in;
					   state <= 0;
					   done <= 0;
				   end
			   end
			default: begin
					 state <= 0;
					 prev_byte <= 0;
					 done <= 0;
				 end
		endcase
	end
end

endmodule
