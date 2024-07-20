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
        // add a default assignment to maintain the previous value of q
        q = q;
    end
end

endmodule
