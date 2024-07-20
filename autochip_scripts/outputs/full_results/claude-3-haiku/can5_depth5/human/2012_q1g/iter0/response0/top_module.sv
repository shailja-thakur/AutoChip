module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    f = (x[3:2] == 2'b00 && x[4:1] == 4'b1001) || // 1001
        (x[3:2] == 2'b11 && x[4:1] != 4'b0000);  // 1110, 1111, 1101
end

endmodule
