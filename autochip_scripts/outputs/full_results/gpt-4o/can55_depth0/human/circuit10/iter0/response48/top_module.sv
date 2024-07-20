module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        if (a & b) begin
            state <= 0;
        end else if (a & ~b) begin
            state <= 1;
        end
        
        if ((a & b) | (~a & ~b)) begin
            q <= state;
        end else if (a & ~b) begin
            q <= 1;
        end else if (~a & b) begin
            q <= 0;
        end
    end
endmodule
