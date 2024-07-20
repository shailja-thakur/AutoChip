module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    if (({x[4], x[3]} == 2'b00) || ({x[4], x[3]} == 2'b10))
        f = x[2] & ~x[1];
    else if ({x[4], x[3]} == 2'b11)
        f = 1'b1;
    else
        f = 1'b0;
end

endmodule
