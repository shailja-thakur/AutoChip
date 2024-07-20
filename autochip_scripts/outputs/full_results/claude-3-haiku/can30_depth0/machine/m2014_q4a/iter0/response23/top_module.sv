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
        // Output should remain unchanged when enable is inactive
        // No assignment is required here, as q will maintain its previous value
    end
end

endmodule
