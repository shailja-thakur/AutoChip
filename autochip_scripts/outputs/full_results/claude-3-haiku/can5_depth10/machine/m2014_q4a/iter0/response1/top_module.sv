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
        q = q; // No change to q when ena is low
    end
end

endmodule
