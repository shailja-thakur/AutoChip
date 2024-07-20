module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    reg memory;

    always @(posedge clk) begin
        if (a && b) begin
            memory <= ~memory;
        end
    end

    always @(posedge clk) begin
        if (a)
            state <= 1'b1; 
        else
            state <= 1'b0;
    end
    
    assign q = memory;

endmodule
