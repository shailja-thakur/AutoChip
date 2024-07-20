module top_module (
    input d,
    input ena,
    output logic q
);

always_comb begin
    if (ena)
        q = d;
    else
        q = q; // Maintain the previous value of q when ena is low
end

endmodule
