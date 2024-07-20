module top_module (
    input clk,
    input w,
    input [n-1:0] R,
    input E,
    input L,
    output reg [n-1:0] Q
);

    always @(posedge clk) begin
        if (L) begin
            Q <= R;
        end
        else if (E) begin
            Q <= {Q[n-2:0], w};
        end
    end

endmodule
