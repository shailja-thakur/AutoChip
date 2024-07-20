module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

reg [3:0] out_reg;

always @(*) begin
    case (sel)
        0: out_reg = in[3:0];
        1: out_reg = in[7:4];
        2: out_reg = in[11:8];
        3: out_reg = in[15:12];
        // ...
        // Complete the case statement for all 256 possible values of sel
        // Each case should assign the appropriate 4-bit value from input 'in' to 'out_reg'
        
        default: out_reg = 4'b0; // Default value to set when sel is not in the range of 0-255
    endcase
end

assign out = out_reg;

endmodule
