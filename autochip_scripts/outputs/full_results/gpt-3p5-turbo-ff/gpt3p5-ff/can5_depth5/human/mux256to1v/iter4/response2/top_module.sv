module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

reg [3:0] in_sel;
    
always @(sel) begin
    case(sel)
        0: in_sel = in[3:0];
        1: in_sel = in[7:4];
        2: in_sel = in[11:8];
        // Continue the case for all 256 selections
        default: in_sel = 4'd0;
    endcase
end

assign out = in_sel;

endmodule
