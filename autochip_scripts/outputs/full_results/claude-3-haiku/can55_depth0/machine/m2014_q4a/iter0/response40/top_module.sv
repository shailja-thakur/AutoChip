module top_module (
    input d,
    input ena,
    output logic q
);

always_comb begin
    if (ena) begin
        q = d;
    end
    // No need for else statement, as the output will remain unchanged when ena is 0
end

endmodule
