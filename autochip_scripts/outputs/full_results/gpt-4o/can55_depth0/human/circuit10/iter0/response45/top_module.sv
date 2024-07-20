module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        if (a && b) 
            state <= 0;
        else 
            state <= (b) ? 1 : state;
    end

    always @(posedge clk) begin
        if (a && b) 
            q <= 0;
        else 
            q <= (b) ? 1 : state;
    end

endmodule
