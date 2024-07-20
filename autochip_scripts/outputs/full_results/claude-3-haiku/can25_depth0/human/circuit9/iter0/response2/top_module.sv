module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a) begin
        if (q == 4) begin
            q <= 4;
        end else begin
            q <= q + 1;
        end
    end else begin
        if (q == 0) begin
            q <= 1;
        end else if (q == 6) begin
            q <= 0;
        end else begin
            q <= q;
        end
    end
end

endmodule
