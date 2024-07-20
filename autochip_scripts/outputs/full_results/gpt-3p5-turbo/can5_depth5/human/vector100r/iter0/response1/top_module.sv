module top_module (
    input [99:0] in,
    output reg [99:0] out
);

    reg [99:0] reverse;

    integer i;

    always @*
    begin
        for (i = 0; i < 100; i = i + 1)
        begin
            reverse[i] = in[99 - i];
        end
    end

    assign out = reverse;

endmodule
