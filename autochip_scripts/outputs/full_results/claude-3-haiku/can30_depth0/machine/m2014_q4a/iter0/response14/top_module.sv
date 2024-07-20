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
        // Keep the output unchanged when enable is inactive
        // No need for an explicit assignment here
    end
end

endmodule
