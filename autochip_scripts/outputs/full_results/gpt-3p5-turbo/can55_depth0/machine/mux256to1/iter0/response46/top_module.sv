module top_module (
    input [255:0] in,
    input [7:0] sel,
    output  out
);

    reg [7:0] addr;
    
    always @(*) begin
        addr = sel;
    end
    
    assign out = in[addr];    
endmodule
