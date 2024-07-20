module top_module (
    input d,
    input ena,
    output logic q
);

always_comb begin
    if (ena) begin
        q = d;
    end else begin
        // q should remain unchanged when ena is 0
        // no need to assign anything, as q is declared as logic
    end
end

endmodule
