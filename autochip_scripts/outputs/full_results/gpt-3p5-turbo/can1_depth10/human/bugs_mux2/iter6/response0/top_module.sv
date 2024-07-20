module top_module (
    input sel,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out
);

    always @(sel, a, b) begin
        if (sel)
            out <= b; // Use non-blocking assignment for sequential logic
        else
            out <= a; // Use non-blocking assignment for sequential logic
    end

endmodule
