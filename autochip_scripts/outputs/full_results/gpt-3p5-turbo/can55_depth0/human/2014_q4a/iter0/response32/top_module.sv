module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

    wire select;
    wire D;

    // Single D Flip Flop
    always @(posedge clk) begin
        if (L) begin
            Q <= R;
        end else if (E) begin
            Q <= select;
        end
    end

    // Mux
    assign select = w ? D : Q;
    assign D = Q;    

endmodule
