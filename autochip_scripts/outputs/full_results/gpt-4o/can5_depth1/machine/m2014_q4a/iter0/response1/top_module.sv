module top_module (
    input d,
    input ena,
    output logic q
);

always_comb begin
    if (ena)
        q = d;
    else
        q = q; // Output remains unchanged when ena is low
end

endmodule
