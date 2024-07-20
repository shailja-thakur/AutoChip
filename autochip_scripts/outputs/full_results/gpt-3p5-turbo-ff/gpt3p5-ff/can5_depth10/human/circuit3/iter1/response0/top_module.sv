module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Define internal signals
	wire w1, w2, w3, w4, w5;
	reg q_temp;

	// Assign internal signals based on combinational logic
	assign w1 = ~(a | b);
	assign w2 = ~(c & d);
	assign w3 = ~(b & c);
	assign w4 = ~(d | w3);
	assign w5 = ~(w2 & w3);

	// Assign output q_temp based on internal signals
	assign q_temp = ~(a & b & c & d & w1 & w4 & w5);

	// Delay assignment of q to match the simulation waveform
	always @(posedge clk, negedge rst) begin
		if (!rst) begin
			q <= 0;
		end else begin
			q <= q_temp;
		end
	end

endmodule
