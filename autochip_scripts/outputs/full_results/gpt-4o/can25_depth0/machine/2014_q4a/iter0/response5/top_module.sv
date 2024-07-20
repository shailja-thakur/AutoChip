module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);
    always @(posedge clk) begin
        if (R) begin
            Q <= 0;  // Reset output to 0 when R is high
        end else if (E) begin
            if (L) begin
                Q <= R;  // Load R into Q when L is high
            } else begin
                Q <= w;  // Load w into Q when L is low
            end
        end
    end
endmodule
