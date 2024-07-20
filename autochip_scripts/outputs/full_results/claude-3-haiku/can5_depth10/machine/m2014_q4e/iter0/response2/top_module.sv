module top_module (
    input wire in1,
    input wire in2,
    output logic out
);

always_comb begin
    out = ~(in1 | in2);
end

endmodule
