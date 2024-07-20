module top_module (
    input clk,
    input a,
    output reg q
);

// Positive edge triggered always block
always @(posedge clk) begin
    // Assign the inverse value of input a to output q
    q <= ~a;
end

endmodule
