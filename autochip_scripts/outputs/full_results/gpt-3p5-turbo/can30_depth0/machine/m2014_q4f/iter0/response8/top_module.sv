module top_module (
    input in1,
    input in2,
    output logic out
);

    // Logic for the output signal
    always_comb begin
        if (in1 && !in2) begin
            out = 1;
        end
        else begin
            out = 0;
        end
    end

endmodule
