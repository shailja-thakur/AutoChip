module top_module (
    input [4:1] x,
    output wire f
);

assign f = (x[3] & x[4]) | (~x[1] & x[2]);

endmodule
