module top_module (
    input d,
    input ena,
    output logic q
);

    always_comb begin
        if (ena)
            q = d;  // output port will be equal to the input port when enable is active
        else
            q = q;  // output port will remain unchanged when enable is inactive
    end

endmodule
