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
        // No assignment is needed here
    end
end

endmodule
