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
        // q should remain unchanged when ena is low
        // no need to explicitly assign q, as it will retain its previous value
    end
end

endmodule
