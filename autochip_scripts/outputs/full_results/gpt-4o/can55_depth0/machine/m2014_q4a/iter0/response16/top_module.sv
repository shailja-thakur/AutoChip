module top_module (
    input d,
    input ena,
    output logic q
);

    // Internal register to hold the previous state of q
    logic q_internal;

    always_comb begin
        if (ena) begin
            q_internal = d;
        end
    end

    // Assign the internal register to the output
    assign q = q_internal;

endmodule
