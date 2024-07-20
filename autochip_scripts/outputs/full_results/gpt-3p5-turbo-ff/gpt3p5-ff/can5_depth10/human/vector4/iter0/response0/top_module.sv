module top_module (
    input [7:0] in,
    output [31:0] out
);
    
    wire [7:0] sign_ext;
    wire [7:0] replicated_sign_bit;
    
    assign sign_ext = {24{in[7]}};
    assign replicated_sign_bit = {24{in[7]}};
    
    assign out = {replicated_sign_bit, in};
    
endmodule
