module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// Output in minimum sum-of-products form
assign out_sop = (!a & !b & !c & !d) | // 0
                (a & !b & !c & !d) | // 1
                (!a & b & !c & !d) | // 4
                (!a & !b & c & !d) | // 5
                (!a & !b & !c & d) | // 6
                (a & b & c & !d) | // 7
                (a & b & !c & d) | // 14
                (a & !b & c & d) | // 15
                (!a & b & c & d); // 13

// Output in minimum product-of-sums form
assign out_pos = (a + b + !c + !d) & (!a + !b + c + !d) & (!a + !b + !c + d);

endmodule
