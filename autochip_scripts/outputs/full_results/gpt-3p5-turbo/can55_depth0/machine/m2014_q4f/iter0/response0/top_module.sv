module top_module (
    input in1,
    input in2,
    output logic out
);

    // Perform logical AND of in1 and the logical NOT of in2
    always_comb begin
        if (in1 && !in2)
            out = 1;
        else
            out = 0;
    end

endmodule
