module top_module (
    input d,
    input ena,
    output logic q
);

always_comb begin
    if (ena) begin
        q = d;
    end
    // No need for else, as q will maintain its previous value when ena is low
end

endmodule
