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
        // When ena is inactive (low), the output port should remain unchanged
        // Instead of assigning a default value, we can use the q variable itself
        // to maintain the previous value of the output
    end
end

endmodule
