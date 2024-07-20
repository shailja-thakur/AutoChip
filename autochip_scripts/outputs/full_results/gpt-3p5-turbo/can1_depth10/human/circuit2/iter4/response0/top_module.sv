module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    reg q_reg;

    always @(*) begin
        if (!a && !b && !c && d) q_reg = 1;
        else if (!a && !b && c && !d) q_reg = 1;
        else if (!a && b && !c && !d) q_reg = 1;
        else if (!a && b && c && d) q_reg = 1;
        else if (a && !b && !c && d) q_reg = 1;
        else if (a && !b && c && !d) q_reg = 1;
        else if (a && b && !c && d) q_reg = 1;
        else if (a && b && c && !d) q_reg = 1;
        else q_reg = 0;
    end

    assign q = q_reg;

endmodule
