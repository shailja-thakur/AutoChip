module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    f = (x[4] & x[3] & ~x[2] & ~x[1]) // 0x1
       | (~x[4] & x[3] & ~x[2] & x[1]) // 1x0
       | (x[4] & x[3] & x[2] & ~x[1]) // 11x
       | (x[4] & ~x[3] & ~x[2] & x[1]); // 1x1
end

endmodule
