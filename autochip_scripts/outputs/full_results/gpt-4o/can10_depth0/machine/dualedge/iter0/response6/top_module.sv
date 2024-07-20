module top_module(
    input clk,
    input d,
    output reg q);
    
    reg qp, qn;

    // Update qp on positive edge of clk
    always @(posedge clk) begin
        qp <= d;
    end

    // Update qn on negative edge of clk
    always @(negedge clk) begin
        qn <= d;
    end

    // Assign q based on the value of clk
    always @(clk or qp or qn) begin
        if (clk) 
            q = qp;
        else 
            q = qn;
    end
    
endmodule
