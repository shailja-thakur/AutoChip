module top_module(
    input clk,
    input d,
    output reg q
);

	reg [0:0] q_initial;
	
	// Initial block to set the initial value of the register signal q
    initial begin
        q_initial = 1'hx;
    end
	
	// Always block triggered by the rising edge of the clock signal
	always @(posedge clk) begin
		// Set the register signal q to the value of the data signal d
		q <= d;
	end
	
endmodule
