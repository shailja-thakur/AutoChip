module top_module (
    input [7:0] in,
    output parity
);
    reg [7:0] in_reg;
    wire [6:0] xor;
    
    always @(in) begin
        in_reg <= in;
    end
    
    assign xor = in_reg[7] ^ in_reg[6] ^ in_reg[5] ^ in_reg[4] ^ in_reg[3] ^ in_reg[2] ^ in_reg[1] ^ in_reg[0];
    
    assign parity = xor;
    
endmodule
