module top_module (
    input sel,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out
);

always @(*) begin
    if(sel == 0)
        out = b;
    else if(sel == 1)
        out = a;
    else
        out = 0; // Default value when 'sel' is neither 0 nor 1. Can be changed accordingly.
end

endmodule
