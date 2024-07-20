module top_module (
    input [7:0] in,
    output [31:0] out
);
    
    wire [31:0] replicated_bits;
    
    assign replicated_bits = {24{in[7]}, in};
    assign out = replicated_bits;
    
endmodule
