module top_module (
    input clk,
    input d,
    input r,
    output logic q
);
    
    logic q_next;
    
    always_ff @(posedge clk)
    begin
        if (r == 1'b1)
            q_next <= 1'b0;
        else
            q_next <= d;
    end
    
    assign q = q_next;
    
endmodule
