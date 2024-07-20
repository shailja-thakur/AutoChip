module top_module (
    input in1,
    input in2,
    output logic out
);

    always_comb begin
        out = ~(in1 | in2);
    end
    
endmodule
