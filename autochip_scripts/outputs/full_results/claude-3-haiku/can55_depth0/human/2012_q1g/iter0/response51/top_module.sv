module top_module (
    input [4:1] x,
    output logic f
);

logic [3:0] minterms;

assign minterms[0] = ~x[4] & ~x[3] & x[2] & x[1];
assign minterms[1] = ~x[4] & ~x[3] & ~x[2] & ~x[1];
assign minterms[2] = ~x[4] & x[3] & x[2] & ~x[1];
assign minterms[3] = x[4] & ~x[3] & x[2] & x[1];

assign f = |minterms;

endmodule
