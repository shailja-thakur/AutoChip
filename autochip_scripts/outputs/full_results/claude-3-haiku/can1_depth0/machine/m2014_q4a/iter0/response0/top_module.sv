module top_module (
    input d,
    input ena,
    output logic q
);

always @(*) begin
    if (ena) begin
        q = d;
    end
    // No action needed when ena is low, q remains unchanged
end

endmodule
