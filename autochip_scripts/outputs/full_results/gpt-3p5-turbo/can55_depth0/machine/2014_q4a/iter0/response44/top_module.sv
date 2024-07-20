module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

always @(posedge clk) begin
    if (E == 1'b0) begin
        // hold current state
    end else begin
        if (L == 1'b1) begin
            Q <= 1'b0; // update with R
        end else begin
            Q <= w; // update with w
        end
    end

    if (R == 1'b1) begin
        Q <= 1'b0; // reset
    end
end

endmodule
