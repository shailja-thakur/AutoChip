module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [1:0] state;
reg start_message;
reg [1:0] counter;
reg [1:0] prev_counter;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		start_message <= 0;
		counter <= 0;
		prev_counter <= 0;
	end
	else begin
		case (state)
			0: begin
				if (in[3] == 1) begin
					state <= 1;
					start_message <= 1;
					counter <= 0;
				end
			end
			1: begin
				counter <= counter + 1;
				if (counter == 2) begin
					state <= 2;
					counter <= 0;
				end
			end
			2: begin
				if (in[3] == 1) begin
					state <= 1;
					start_message <= 1;
				end
				else begin
					state <= 0;
					start_message <= 0;
				end
			end
			default: state <= 0;
		endcase
	end
end

assign done = (state == 2) && (prev_counter == 2);

always @(posedge clk) begin
	prev_counter <= counter;
end

endmodule
