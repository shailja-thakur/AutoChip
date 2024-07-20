module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output reg [3:0] out
);

reg [255:0] in_sel [7:0];
integer i;

always @*
begin
    for (i = 0; i < 256; i = i + 1)
    begin
        in_sel[i] <= in[4*i +: 4];
    end
    
    out <= in_sel[sel];
end

endmodule
