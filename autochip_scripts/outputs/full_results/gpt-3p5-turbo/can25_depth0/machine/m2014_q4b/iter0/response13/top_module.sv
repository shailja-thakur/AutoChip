module top_module (
    input clk,
    input d,
    input ar,
    output reg q // declare q as a reg type
);

reg q; // declare q as a reg type

always @(posedge clk or posedge ar) begin // trigger on posedge for both clk and ar
    if (ar == 1'b1) // use 1'b1 instead of 1, to represent a binary value
        q <= 1'b0; // assign 1'b0 instead of 0, to represent a binary value
    else if (clk == 1'b1) // use 1'b1 instead of 1, to represent a binary value
        q <= d; // assign the value of d to q
end

endmodule
