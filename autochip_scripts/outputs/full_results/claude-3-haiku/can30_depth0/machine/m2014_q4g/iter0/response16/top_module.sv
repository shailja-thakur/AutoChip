module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    logic intermediate;

    always_comb begin
        intermediate = in1 ^ in2;
        out = ~intermediate ^ in3;
    end

endmodule
