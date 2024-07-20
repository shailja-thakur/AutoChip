module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

    always @(posedge clk or posedge R) begin
        if (R) begin
            Q <= 0;
        end else if (L) begin
            Q <= w;
        end else if (E) begin
            Q <= w;
        end
    end

endmodule
