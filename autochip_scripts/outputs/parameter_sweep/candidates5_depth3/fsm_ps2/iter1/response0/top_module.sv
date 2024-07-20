module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [2:0] state;
reg start_message;
reg [1:0] counter;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		start_message <= 0;
		counter <= 0;
	end
	else begin
		case (state)
			0: begin
				if (in[3] == 1) begin
					state <= 1;
					start_message <= 1;
				end
			end
			1: begin
				if (counter == 1) begin
					state <= 2;
				end
				else begin
					counter <= counter + 1;
				end
			end
			2: begin
				if (in[3] == 1) begin
					state <= 1;
					start_message <= 1;
				end
			end
			default: state <= 0;
		endcase
	end
end

assign done = (state == 1 && counter == 1);

endmodule
