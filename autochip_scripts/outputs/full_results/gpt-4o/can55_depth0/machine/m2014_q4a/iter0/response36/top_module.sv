module top_module (
    input d,
    input ena,
    output logic q
);
    // Internal signal to hold the value of q
    logic q_internal;

    // Always block to handle the logic
    always @(*) begin
        if (ena) begin
            q_internal = d;
        end
    end

    assign q = q_internal;

endmodule
