module top_module (
    input d,
    input ena,
    output logic q
);

always_comb begin
    if (ena) begin
        q = d;
    end
    // No need for else block since q will retain its previous value when ena is low
end

endmodule
