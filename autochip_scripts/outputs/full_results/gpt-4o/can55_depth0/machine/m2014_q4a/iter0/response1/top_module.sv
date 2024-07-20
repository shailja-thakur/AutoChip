module top_module (
    input d,
    input ena,
    output logic q
);
    always @(*) begin
        if (ena)
            q = d;
        else
            q = q;  // Output remains unchanged
    end
endmodule
