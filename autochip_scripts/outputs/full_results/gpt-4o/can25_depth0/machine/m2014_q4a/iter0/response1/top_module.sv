module top_module (
    input d,
    input ena,
    output logic q
);

    always_comb begin
        if (ena)
            q = d;   // When enable is high, q follows d.
        else
            q = q;   // When enable is low, q remains the same.
    end
    
endmodule
