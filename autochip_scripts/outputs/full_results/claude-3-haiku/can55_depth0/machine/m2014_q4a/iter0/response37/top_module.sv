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
        // Keep the output value unchanged
        // No assignment needed since q is declared as output logic
    end
end

endmodule
