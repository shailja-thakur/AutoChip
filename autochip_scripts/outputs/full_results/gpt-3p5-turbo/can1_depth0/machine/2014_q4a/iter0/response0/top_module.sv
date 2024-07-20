module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

always @(posedge clk) begin
    if (E == 1'b1) begin
        if (L == 1'b1) begin
            Q <= R;
        end else begin
            Q <= w;
        end
    end
end

// handle reset
always @(posedge clk) begin
    if (R == 1'b1) begin
        Q <= 1'b0;
    end
end

endmodule
