module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    f = (x[4] & x[3] & ~x[2] & ~x[1]) | // 00
        (x[4] & ~x[3] & ~x[2] & x[1]) | // 10
        (x[4] & x[3] & x[2] & ~x[1]) | // 11
        (~x[4] & x[3] & ~x[2] & ~x[1]); // 00
end

endmodule
