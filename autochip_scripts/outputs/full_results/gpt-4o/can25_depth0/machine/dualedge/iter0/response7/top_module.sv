module top_module(
    input clk,
    input d,
    output reg q);

    reg qp;  // Register to hold the synchronized value of d on positive edge of clk
    reg qn;  // Register to hold the synchronized value of d on negative edge of clk

    // Always block to capture d on the positive edge of clk
    always @(posedge clk) begin
        qp <= d;
    end

    // Always block to capture d on the negative edge of clk
    always @(negedge clk) begin
        qn <= d;
    end

    // Always block to update q based on the state of clk
    always @(*) begin
        if (clk) begin
            q = qp;
        end else begin
            q = qn;
        end
    end
    
endmodule
