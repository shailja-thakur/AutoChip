module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    f = (x[3:2] == 2'b00 && x[4] == 1'b1) || 
        (x[3:2] == 2'b11 && x[1] == 1'b1) ||
        (x[3:2] == 2'b10 && (x[1] == 1'b1 || x[4] == 1'b1));
end

endmodule
