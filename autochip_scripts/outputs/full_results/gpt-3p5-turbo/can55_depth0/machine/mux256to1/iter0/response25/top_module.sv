module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);

    reg [7:0] address;
    
    always @* begin
        address = sel;
    end
    
    assign out = in[address];
    
endmodule
