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
        // When enable is inactive (low), the output port should remain unchanged
        // Instead of assigning a default value, we can use the 'q' variable directly
        // since it will retain its previous value when the enable is low.
    end
end

endmodule
