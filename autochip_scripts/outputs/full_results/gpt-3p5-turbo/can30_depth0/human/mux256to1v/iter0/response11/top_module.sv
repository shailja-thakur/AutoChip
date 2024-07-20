module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output reg [3:0] out
);

always @(sel) begin
    case(sel)
        0: out = in[3:0];
        1: out = in[7:4];
        2: out = in[11:8];
        // ... continue for other values of sel
        default: out = 4'b0; // default output when sel is out of range
    endcase
end

endmodule
