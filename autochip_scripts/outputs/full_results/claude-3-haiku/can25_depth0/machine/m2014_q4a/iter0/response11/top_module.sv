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
        // No assignment to q, so it retains its previous value
    end
end

endmodule
