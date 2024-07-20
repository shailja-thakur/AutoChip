module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    f = ((x[4:1] == 4'b0000) || (x[4:1] == 4'b1010) || (x[4:1] == 4'b1100) || (x[4:1] == 4'b1110));
end

endmodule
