module top_module (
    input [4:1] x,
    output logic f
);


always_comb begin
    if(x == 4'b0101 || x == 4'b0111 || x == 4'b1011 || x == 4'b1100 || x == 4'b1110 || x == 4'b1111)
        f = 1;
    else
        f = 0;
end


endmodule
