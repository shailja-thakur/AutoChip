module top_module (
    input d,
    input ena,
    output logic q
);

always_comb begin
    if (ena) begin
        q = d;
    end else begin
        // Keep q unchanged
    end
end

endmodule
