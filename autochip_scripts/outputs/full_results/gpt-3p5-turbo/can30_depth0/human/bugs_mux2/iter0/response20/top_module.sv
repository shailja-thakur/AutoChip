module top_module (
    input sel,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out
);

always @(sel or a or b)
begin
    if(sel == 1'b0)
        out = a;
    else
        out = b;
end

endmodule
