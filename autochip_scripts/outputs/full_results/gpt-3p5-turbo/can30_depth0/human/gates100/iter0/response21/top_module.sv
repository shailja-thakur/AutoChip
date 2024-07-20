module top_module (
    input [99:0] in,
    output reg out_and,
    output reg out_or,
    output reg out_xor
);

    reg [99:0] and_out;
    reg [99:0] or_out;
    reg [99:0] xor_out;
    
    always @(*)
    begin
        and_out = &in;
        or_out = |in;
        xor_out = ^in;
    end
    
    assign out_and = and_out[99];
    assign out_or = or_out[99];
    assign out_xor = xor_out[99];
    
endmodule
