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
        q = q; // Keep the output unchanged when ena is low
    end
end

endmodule
