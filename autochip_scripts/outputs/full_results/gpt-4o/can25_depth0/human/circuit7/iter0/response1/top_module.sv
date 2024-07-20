module top_module (
    input clk,
    input a,
    output reg q
);
    always @(posedge clk) begin
        if (a == 1'b0) begin
            q <= 1'b1;
        end else begin
            q <= ~q;
        end
    end
endmodule
