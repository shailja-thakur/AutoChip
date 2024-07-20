module top_module (
    input sel,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out
);

always @(*)
begin
    if(sel == 1'b0)
        out = a;
    else if(sel == 1'b1)
        out = b;
    else
        out = 8'b0; // Default value for sel other than 0 or 1
end

endmodule
