module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

// Mealy machine state variables
reg [2:0] next_q;

// Combinational logic to determine next state and output
always @ (posedge clk) begin
	if (a) begin
		next_q <= 3'b100; // Set q to 4 when a is 1
	end else begin
		if (q == 3'b110) // Check if q is 6
			next_q <= 3'b000; // Set q to 0
		else
			next_q <= q + 1; // Increase q by 1 if q is not 6
	end
end

// Sequential logic to update current state
always @ (posedge clk) begin
	q <= next_q;
end

endmodule
