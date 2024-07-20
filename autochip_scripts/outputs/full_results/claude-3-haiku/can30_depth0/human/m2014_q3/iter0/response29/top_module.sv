module top_module (
    input [4:1] x,
    output logic f
);

assign f = (x[4:3] == 2'b01) ? x[2] :
           (x[4:3] == 2'b11) ? 1'b1 :
           (x[4:3] == 2'b10) ? 1'b1 :
           1'b0;

endmodule
