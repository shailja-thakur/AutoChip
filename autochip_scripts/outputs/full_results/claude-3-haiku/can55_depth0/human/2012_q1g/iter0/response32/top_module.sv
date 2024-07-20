module top_module (
    input [4:1] x,
    output logic f
);

logic [3:0] minterms;

assign minterms[0] = (x[4] == 1'b0) & (x[3] == 1'b0) & (x[2] == 1'b0) & (x[1] == 1'b0);
assign minterms[1] = (x[4] == 1'b0) & (x[3] == 1'b0) & (x[2] == 1'b1) & (x[1] == 1'b0);
assign minterms[2] = (x[4] == 1'b1) & (x[3] == 1'b1) & (x[2] == 1'b1) & (x[1] == 1'b0);
assign minterms[3] = (x[4] == 1'b1) & (x[3] == 1'b1) & (x[2] == 1'b0) & (x[1] == 1'b0);

always_comb begin
    f = minterms[0] | minterms[2] | minterms[3] | minterms[2];
end

endmodule
