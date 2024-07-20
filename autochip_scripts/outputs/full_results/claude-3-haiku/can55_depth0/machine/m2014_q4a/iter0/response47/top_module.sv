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
        // Keep the output q unchanged when ena is low
        // No assignment needed here, as q will maintain its previous value
    end
end

endmodule
