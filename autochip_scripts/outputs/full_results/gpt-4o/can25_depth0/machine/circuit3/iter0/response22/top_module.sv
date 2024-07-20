module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    wire ab_or, cd_or;

    // Perform OR operation on inputs a and b
    assign ab_or = a | b;

    // Perform OR operation on inputs c and d
    assign cd_or = c | d;

    // Perform AND operation on the result of the OR operations
    assign q = ab_or & cd_or;

endmodule
