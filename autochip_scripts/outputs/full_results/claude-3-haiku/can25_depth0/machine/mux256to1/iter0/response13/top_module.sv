module top_module (
    input [255:0] in,
    input [7:0] sel,
    output reg out
);

always @(*) begin
    // Use the selection vector to index into the input vector and assign the corresponding bit to the output
    out = in[sel];
end

endmodule
