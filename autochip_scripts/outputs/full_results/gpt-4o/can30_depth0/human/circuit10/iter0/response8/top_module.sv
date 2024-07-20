module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);
    
    // State register
    always @(posedge clk) begin
        if (a == 1 && b == 0)
            state <= 0;
        else if (a == 1 && b == 1)
            state <= ~state;
        else if (a == 0 && b == 1)
            state <= 1;
    end
    
    // Output logic
    always @(posedge clk) begin
        q <= state;
    end

endmodule
