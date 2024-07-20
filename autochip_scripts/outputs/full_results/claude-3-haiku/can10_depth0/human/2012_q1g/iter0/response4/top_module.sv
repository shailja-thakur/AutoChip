module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    f = (x[3] & x[4] & ~x[1] & ~x[2]) | // 1000
        (~x[3] & x[4] & x[1] & x[2]) | // 0111
        (x[3] & ~x[4] & x[1] & x[2]) | // 1011
        (x[3] & x[4] & ~x[1] & x[2]); // 1010
end

endmodule
