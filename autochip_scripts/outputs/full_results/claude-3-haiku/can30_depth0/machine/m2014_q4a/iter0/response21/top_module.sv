module top_module (
    input d,
    input ena,
    output logic q
);

always_comb begin
    if (ena) begin
        q = d;
    end
    else begin
        // When ena is low, q should remain unchanged
        // No assignment is needed here since q is declared as a logic type
    end
end

endmodule
