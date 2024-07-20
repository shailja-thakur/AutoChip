module top_module (
    input d,
    input ena,
    output logic q
);

always_comb begin
    if (ena) begin
        q = d;
    end
    // No need for an else statement, as the output q will remain unchanged when ena is low
end

endmodule
