module top_module (
    input d,
    input ena,
    output logic q
);

    // Internal register to hold the value of q
    logic q_int;

    always_comb begin
        if (ena)
            q_int = d;
        else
            q_int = q_int; // Maintain the previous value
    end

    // Assign the internal register to the output
    assign q = q_int;

endmodule
