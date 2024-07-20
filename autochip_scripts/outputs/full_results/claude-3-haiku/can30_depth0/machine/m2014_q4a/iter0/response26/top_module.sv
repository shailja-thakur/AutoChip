module top_module (
    input  wire d,
    input  wire ena,
    output logic q
);

always_comb begin
    if (ena) begin
        q = d;
    end
    // If ena is 0, keep q unchanged
end

endmodule
