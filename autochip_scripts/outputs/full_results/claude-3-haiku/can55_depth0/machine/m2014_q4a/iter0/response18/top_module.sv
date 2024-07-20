module top_module (
    input d,
    input ena,
    output logic q
);

always_comb begin
    if (ena) begin
        q = d;
    end else begin
        // q should remain unchanged when ena is low
        // no need to assign a value to q explicitly
    end
end

endmodule
