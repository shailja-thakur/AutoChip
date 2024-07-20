module top_module(
    input clk,
    input d,
    input r,
    output reg q
);
    always @(posedge clk) begin
        if (r) begin
            q <= 0;
        end else begin
            q <= d;
        end
    end
endmodule
