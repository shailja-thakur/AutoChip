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
        // The output should remain unchanged when ena is low
        // No need to assign a value to q in this case
    end
end

endmodule
