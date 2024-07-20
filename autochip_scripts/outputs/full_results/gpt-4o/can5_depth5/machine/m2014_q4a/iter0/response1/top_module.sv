module top_module (
    input d,
    input ena,
    output logic q
);
    // Intermediate register to hold the output value
    logic q_reg;

    // Always block to implement the combinational logic
    always_comb begin
        if (ena) 
            q_reg = d;
    end

    // Assign the output port to the intermediate register
    assign q = q_reg;

endmodule
