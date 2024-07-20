module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
	// Define signals
	reg [3:0] d;

	// Flop declarations
	reg q1, q2, q3, q4;
	reg [3:0] next_d;

	// Assign flop inputs
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			q1 <= 1'b0;
			q2 <= 1'b0;
			q3 <= 1'b0;
			q4 <= 1'b0;
		end else begin
			q1 <= next_d[0];
			q2 <= next_d[1];
			q3 <= next_d[2];
			q4 <= next_d[3];
		end
	end

	// Assign flop outputs to the shift register output
	assign out = q4;

	// Assign next_d based on the input and current flops' states
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			next_d <= 4'b0;
		end else begin
			next_d <= d << 1;
			next_d[0] <= in;
		end
	end
endmodule
