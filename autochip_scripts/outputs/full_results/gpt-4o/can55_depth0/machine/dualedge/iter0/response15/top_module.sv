module top_module(
    input clk,
    input d,
    output reg q);

    reg qp;    // Register to hold value when clk is positive
    reg qn;    // Register to hold value when clk is negative
    
    always @(posedge clk) begin
        qp <= d;  // Update qp with d when clock is positive
    end
    
    always @(negedge clk) begin
        qn <= d;  // Update qn with d when clock is negative
    end
    
    always @(*) begin
        if (clk) begin
            q = qp;  // Output qp when clock is positive
        end else begin
            q = qn;  // Output qn when clock is negative
        end
    end

endmodule
