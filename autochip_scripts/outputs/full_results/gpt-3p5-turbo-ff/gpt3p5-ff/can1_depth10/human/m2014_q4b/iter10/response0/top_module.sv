module top_module (
    input clk,    // Clock input
    input d,      // Data input
    input ar,     // Asynchronous reset input
    output reg q // Output
);

    always @(posedge clk or negedge ar) begin
        if (!ar) begin
            q <= 1'b0;          // Reset
        end else if (clk) begin
            q <= d;          // Flip flop
        end
    end

endmodule
