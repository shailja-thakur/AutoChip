module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    f = (x[3] & x[4] & ~x[1] & ~x[2]) |   // Minterms 0 and 6
        (x[3] & x[4] & x[1] & ~x[2]) |   // Minterms 2, 3, and 7
        (~x[3] & x[4] & ~x[1] & x[2]) |  // Minterm 8
        (x[3] & ~x[4] & x[1] & x[2]);    // Minterms 10 and 11
end

endmodule
