module top_module (
    input d,
    input ena,
    output logic q
);

always_comb begin
    if (ena) begin
        q = d;
    end
    // No else block needed, as q will retain its previous value when ena is 0
end

endmodule
