module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a == 1) begin
        q <= 3'd4;
    end else if (a == 0) begin
        if (q == 3'd6) begin
            q <= 3'd0;
        end else begin
            q <= q + 3'd1;
        end
    end
end

endmodule
