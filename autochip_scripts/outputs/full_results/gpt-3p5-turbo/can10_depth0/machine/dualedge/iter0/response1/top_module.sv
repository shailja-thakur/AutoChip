module top_module(
    input clk,
    input d,
    output reg q);

    reg qp; // positive edge register
    reg qn; // negative edge register
    
    always @(posedge clk)
    begin
        qp <= d; // update qp at positive edge
    end
    
    always @(negedge clk)
    begin
        qn <= d; // update qn at negative edge
    end
    
    always @(posedge clk or negedge clk)
    begin
        if (clk)
            q <= qp; // assign qp to q when clk is positive
        else
            q <= qn; // assign qn to q when clk is negative
    end

endmodule
