module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    f = (x[4:3] == 2'b00 && x[2:1] == 2'b10) // x[3:0] = 0010
        || (x[4:3] == 2'b00 && x[2:1] == 2'b00) // x[3:0] = 0000
        || (x[4:3] == 2'b11); // x[3:0] = 1100, 1101, 1111
end

endmodule
