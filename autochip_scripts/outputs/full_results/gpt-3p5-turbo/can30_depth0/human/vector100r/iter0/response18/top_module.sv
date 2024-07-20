module top_module (
    input [99:0] in,
    output reg [99:0] out
);

// Assign the bits of the input vector in reverse order to the output vector
integer i;
always @* begin
    for (i = 0; i < 100; i = i + 1) begin
        out[i] = in[99 - i];
    end
end

endmodule
