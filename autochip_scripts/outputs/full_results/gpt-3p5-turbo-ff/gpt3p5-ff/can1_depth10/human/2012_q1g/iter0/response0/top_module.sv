module top_module (
    input [4:1] x,
    output logic f
);

assign f = (x[3]==0 && x[4]==1) ? 1 :
           (x[1]==0 && x[2]==0) ? 0 :
           (x[1]==0 && x[2]==1) ? 0 :
           (x[1]==1 && x[2]==0) ? 1 :
           (x[1]==1 && x[2]==1) ? 1 : 0 ;

endmodule
