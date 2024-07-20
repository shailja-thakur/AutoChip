module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    state <= q;
end

always @* begin
    if (a == 1'b1) begin
        if (b == 1'b1) begin
            q = 1'b0;
        end else begin
            q = 1'b1;
        end
    end else begin
        if (b == 1'b1) begin
            q = 1'b1;
        end else begin
            q = state;
        end
    end
end

endmodule
