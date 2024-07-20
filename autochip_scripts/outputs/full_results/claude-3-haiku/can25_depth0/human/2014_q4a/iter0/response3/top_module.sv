module top_module (
    input clk,
    input w,
    input [n-1:0] R,
    input E,
    input L,
    output reg [n-1:0] Q
);

    always @(posedge clk) begin
        if (L)
            Q <= R;
        else if (E)
            Q <= {Q[n-2:0], w};
    end

endmodule
