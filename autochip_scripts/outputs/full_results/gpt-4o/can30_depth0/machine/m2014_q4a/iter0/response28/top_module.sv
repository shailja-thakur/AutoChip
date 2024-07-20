module top_module (
    input d,
    input ena,
    output logic q
);

always @(*) begin
    if (ena) begin
        q = d;
    end
    // When ena is low, q should retain its previous value.
    // As this is a combinational logic, initial value assignment is not handled here.
end

endmodule
