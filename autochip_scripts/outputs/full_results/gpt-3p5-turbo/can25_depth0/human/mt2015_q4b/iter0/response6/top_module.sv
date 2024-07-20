module top_module(
	input x,
	input y,
	output z);
    
    // Declare internal signals
    reg internal_z;

    // Instantiate the D Flip-Flops
    always @(posedge clk) begin
        internal_z <= x & y;
    end

    // Assign output
    assign z = internal_z;
    
endmodule
