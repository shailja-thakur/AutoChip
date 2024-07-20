module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    f = (x[4:3] == 2'b00) ? x[2] | x[1] : 
        (x[4:3] == 2'b01) ? 1'b0 :
        (x[4:3] == 2'b11) ? 1'b1 :
        (x[4:3] == 2'b10) ? x[2] | x[1] : 
        1'b0;
end

endmodule
