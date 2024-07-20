module top_module (
    input d,
    input ena,
    output logic q
);
    // Internal register to hold the previous state of q
    logic q_reg;
    
    // Combinational logic to control the output q
    always_comb begin
        if (ena)
            q_reg = d;
    end
    
    assign q = q_reg;
    
endmodule
