module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

reg [3:0] out_reg;

always @(in, sel) begin
    case(sel)
        0: out_reg = in[3:0];
        1: out_reg = in[7:4];
        2: out_reg = in[11:8];
        // Add more cases for additional selections
        
        default: out_reg = 4'b0000; // Default case when sel is not valid
    endcase
end

assign out = out_reg;

endmodule
