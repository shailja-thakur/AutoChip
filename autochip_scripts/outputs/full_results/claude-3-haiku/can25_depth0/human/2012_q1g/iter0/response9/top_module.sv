module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    f = (x[3] & ~x[4] & ~x[2] & x[1]) |
        (x[3] & x[4] & ~x[2] & ~x[1]) |
        (x[3] & x[4] & x[2] & ~x[1]);
end

endmodule
