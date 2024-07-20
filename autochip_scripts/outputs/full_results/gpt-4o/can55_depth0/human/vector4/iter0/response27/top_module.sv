module top_module (
    input [7:0] in,
    output [31:0] out
);

    // Sign-extend the 8-bit input to a 32-bit output by replicating the sign bit (bit[7]) 24 times, and concatenating with the original 8-bit number
    assign out = {{24{in[7]}}, in};
    
endmodule
