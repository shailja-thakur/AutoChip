module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    wire ab_or;  // Intermediate wire for OR of a and b
    wire cd_or;  // Intermediate wire for OR of c and d

    assign ab_or = a | b;
    assign cd_or = c | d;
    assign q = ab_or & cd_or;

endmodule
