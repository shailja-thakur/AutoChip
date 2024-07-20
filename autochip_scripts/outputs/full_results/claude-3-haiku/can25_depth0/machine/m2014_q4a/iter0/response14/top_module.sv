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
        // q should remain unchanged when ena is low
        // no assignment is needed here, as q is declared as a logic type
    end
end

endmodule
