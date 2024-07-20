module top_module (
    input [99:0] in,
    output reg [99:0] out
);
// Add logic to reverse the bit ordering of the input vector
integer i;

always @(*)
begin
    for (i = 0; i < 100; i = i + 1) begin
        out[i] = in[99 - i];
    end
end

endmodule
