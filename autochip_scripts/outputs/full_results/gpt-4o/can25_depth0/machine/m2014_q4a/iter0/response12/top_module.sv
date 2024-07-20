module top_module (
    input d,
    input ena,
    output logic q
);

    // Internal register to hold the value of q
    logic q_internal;

    always_comb begin
        if (ena) begin
            q_internal = d;
        end
        // No need for else clause since q_internal retains its value otherwise
    end

    assign q = q_internal;

endmodule
