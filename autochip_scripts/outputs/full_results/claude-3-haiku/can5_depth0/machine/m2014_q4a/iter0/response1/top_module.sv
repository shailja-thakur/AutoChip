module top_module (
    input d,
    input ena,
    output logic q
);

always_comb begin
    if (ena) begin
        q <= d;
    end
    // If ena is 0, q should remain unchanged
end

endmodule
