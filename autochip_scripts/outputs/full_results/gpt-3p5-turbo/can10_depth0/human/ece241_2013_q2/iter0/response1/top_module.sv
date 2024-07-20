module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire [3:0] in;

    assign in = {a, b, c, d};

    // Output out_sop in minimum sum-of-products form
    assign out_sop = (in == 4'b0010) | (in == 4'b0111) | (in == 4'b1111);

    // Output out_pos in minimum product-of-sums form
    assign out_pos = ~(in == 4'b0000) & ~(in == 4'b0001) & ~(in == 4'b0100) & ~(in == 4'b0101) &
                    ~(in == 4'b0110) & ~(in == 4'b1001) & ~(in == 4'b1010) & ~(in == 4'b1101) &
                    ~(in == 4'b1110);

endmodule
