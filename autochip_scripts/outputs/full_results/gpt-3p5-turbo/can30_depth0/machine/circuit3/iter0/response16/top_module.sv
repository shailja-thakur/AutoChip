module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

// Wire declarations
wire ab_or; // OR gate output for inputs a and b
wire cd_or; // OR gate output for inputs c and d

// Gate-level descriptions
or u1 (ab_or, a, b);
or u2 (cd_or, c, d);
and u3 (q, ab_or, cd_or);

endmodule
