module top_module (
    input clk,
    input d,
    input r,
    output logic q
);

    logic q_reg;
    
    always @(posedge clk) begin
        if (r == 1'b1) begin
            q_reg <= 1'b0;
        end else begin
            q_reg <= d;
        end
    end
    
    assign q = q_reg;
    
endmodule
