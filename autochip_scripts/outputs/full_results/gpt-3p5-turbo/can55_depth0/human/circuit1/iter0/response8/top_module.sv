module top_module (
    input a,
    input b,
    output q
);
    // Combinational logic
    assign q = a & ~b;
endmodule
