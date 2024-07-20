module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    f = 0;
    if ((x[4:1] == 4'b0000) || (x[4:1] == 4'b1010) || (x[4:1] == 4'b1100) || (x[4:1] == 4'b1110)) begin
        f = 1;
    end
end

endmodule
