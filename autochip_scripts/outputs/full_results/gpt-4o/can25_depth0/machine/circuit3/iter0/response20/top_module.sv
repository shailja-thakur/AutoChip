module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

    wire ab_or;
    wire cd_or;

    // Perform OR operations on a, b and c, d
    assign ab_or = a | b;
    assign cd_or = c | d;

    // Perform AND operation on the results of the OR operations
    assign q = ab_or & cd_or;

endmodule
