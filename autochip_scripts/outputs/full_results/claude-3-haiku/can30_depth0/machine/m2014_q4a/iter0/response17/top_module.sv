module top_module (
    input d,
    input ena,
    output logic q
);

always_comb begin
    if (ena)
        q = d;
    else
        q = q; // Assign the current value of q to q to keep it unchanged
end

endmodule
