module top_module (
    input [7:0] in,
    output [31:0] out
);

    // Replicate the 8-bit input 24 times
    wire [191:0] replicated_input = {24{in}};
    
    // Concatenate the replicated input with the original input
    assign out = {replicated_input, in};

endmodule
