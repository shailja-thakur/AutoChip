module top_module (
	input clk,
	input in,
	input reset,
	output out
);

// Define the two states
reg [1:0] current_state;
parameter B = 2'b00;
parameter A = 2'b01;

// Define the next state logic
always @(posedge clk or posedge reset) begin
	if (reset) begin
		current_state <= B;
	end else begin
		if (current_state == B) begin
			if (in) begin
				current_state <= B;
			end else begin
				current_state <= A;
			end
		end else begin
			if (in) begin
				current_state <= A;
			end else begin
				current_state <= B;
			end
		end
	end
end

// Define the output logic
always @(current_state) begin
	if (current_state == B) begin
		out <= 1;
	end else begin
		out <= 0;
	end
end

endmodule
