module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    f = (x[4:3] == 2'b00 & x[2:1] == 2'b10) | 
        (x[4:3] == 2'b11)                  |
        (x[4:3] == 2'b10 & x[2:1] != 2'b10);
end

endmodule
