module top_module (
    input in1,
    input in2,
    output logic out
);

    // Combinational logic for output signal
    always_comb begin
        out = ~(in1 | in2);
    end

endmodule
