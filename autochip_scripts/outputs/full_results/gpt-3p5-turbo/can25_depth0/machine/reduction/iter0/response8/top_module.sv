module top_module (
    input [7:0] in,
    output parity
);

    wire [7:0] xor_result;
    
    assign xor_result = ^in;
    assign parity = xor_result;
    
endmodule
