module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        state <= q;
        if (a == 1'b1 && b == 1'b1) begin
            q <= ~q;
        end else if (a == 1'b1 && b == 1'b0) begin
            q <= 1'b1;
        end else if (a == 1'b0 && b == 1'b1) begin
            q <= 1'b0;
        end else begin
            q <= q;
        end
    end

endmodule
