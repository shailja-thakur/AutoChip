module top_module (
    input [4:1] x,
    output logic f
);

assign f = (x[4:3] == 2'b11) || (x[2:1] == 2'b01 && x[3] == 1'b1) || (x[2:1] == 2'b10 && x[3] == 1'b1);

endmodule
