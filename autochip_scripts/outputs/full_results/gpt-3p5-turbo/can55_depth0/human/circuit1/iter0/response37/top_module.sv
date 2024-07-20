module top_module (
    input a,
    input b,
    output q
);

    // Define combinational logic for q output
    assign q = a & b;

endmodule
