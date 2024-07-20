module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);
    reg [255:0] selected_bits;
    always @*
    begin
        selected_bits = in & ((1 << sel) - 1);
        out = selected_bits[sel];
    end
endmodule
