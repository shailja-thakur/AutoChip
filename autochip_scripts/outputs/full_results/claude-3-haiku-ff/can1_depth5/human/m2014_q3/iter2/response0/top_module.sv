module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    f = 0;
    if (x[4:1] == 4'b0101) 
        f = 1;
    else if (x[4:3] == 2'b11 && (x[2:1] == 2'b00 || x[2:1] == 2'b01 || x[2:1] == 2'b11))
        f = 1;
end

endmodule
