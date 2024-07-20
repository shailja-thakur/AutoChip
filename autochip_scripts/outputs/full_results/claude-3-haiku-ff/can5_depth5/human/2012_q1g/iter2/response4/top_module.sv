module top_module (
    input [4:1] x,
    output logic f
);

logic [3:0] temp;

always_comb begin
    temp[0] = x[4] & ~x[3];
    temp[1] = x[3] & ~x[2] & ~x[1]; 
    temp[2] = x[4] & x[3] & x[2];
    temp[3] = x[4] & x[2] & ~x[1];
    f = |temp;
end

endmodule
