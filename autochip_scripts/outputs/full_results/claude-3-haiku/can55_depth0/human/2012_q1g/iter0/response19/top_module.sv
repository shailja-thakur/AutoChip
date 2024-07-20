module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    f = (x[4] & x[3] & ~x[2] & ~x[1]) | // 1000
        (~x[4] & x[3] & ~x[2] & x[1]) | // 0100
        (x[4] & x[3] & x[2] & ~x[1]) | // 1110
        (x[4] & ~x[3] & x[2] & x[1]); // 1011
end

endmodule
