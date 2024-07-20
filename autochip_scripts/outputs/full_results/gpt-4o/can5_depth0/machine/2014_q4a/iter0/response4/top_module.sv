module top_module (
    input wire clk,
    input wire w,
    input wire R,
    input wire E,
    input wire L,
    output reg Q
);

    always @(posedge clk or posedge R) begin
        if (R) begin
            Q <= 1'b0; // Reset Q to 0 when R is high
        end else if (E) begin
            if (L) begin
                Q <= R; // Update Q with R if L is high
            } else begin
                Q <= w; // Update Q with w if L is low
            end
        end
    end

endmodule
