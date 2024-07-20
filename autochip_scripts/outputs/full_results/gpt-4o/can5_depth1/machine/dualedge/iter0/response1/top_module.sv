module top_module(
    input clk,
    input d,
    output reg q);
    
    reg qp, qn;

    // Positive edge triggered always block to update qp
    always @(posedge clk) begin
        qp <= d;
    end

    // Negative edge triggered always block to update qn
    always @(negedge clk) begin
        qn <= d;
    end

    // Combinational logic to assign q based on the value of clk
    always @(*) begin
        if (clk)
            q = qp;
        else
            q = qn;
    end

endmodule
