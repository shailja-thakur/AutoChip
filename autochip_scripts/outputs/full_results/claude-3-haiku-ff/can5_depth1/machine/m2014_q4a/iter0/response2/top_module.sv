module top_module (
    input wire d,
    input wire ena,
    output logic q
);

always_comb begin
    if (ena) begin
        q = d;
    end
    // If ena is not high, keep the current value of q
end

endmodule
