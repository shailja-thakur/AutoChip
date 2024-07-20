module top_module (
    input clk,
    input a,
    output reg q
);

always @(posedge clk) begin
    if (a == 0) begin
        q <= q;
    end else begin
        if (q == 0) begin
            q <= 1;
        end else begin
            q <= 0;
        end
    end
end

endmodule
