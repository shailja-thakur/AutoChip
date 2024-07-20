module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);
    always @(posedge clk) begin
        if (a == 1'b1 && b == 1'b1) begin
            state <= ~state;
        end else if (a == 1'b1 && b == 1'b0) begin
            state <= 0;
        end else if (a == 1'b0 && b == 1'b1) begin
            state <= 1;
        end
        q <= state;
    end
endmodule
