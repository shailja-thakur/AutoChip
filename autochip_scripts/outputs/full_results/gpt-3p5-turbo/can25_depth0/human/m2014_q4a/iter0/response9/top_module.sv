module top_module (
    input d,
    input ena,
    output logic q
);
    reg q_reg;
    
    always @(posedge ena) begin
        if (ena)
            q_reg = d;
    end
    
    assign q = q_reg;
endmodule
