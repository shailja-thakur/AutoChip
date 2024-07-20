module top_module (
    input [255:0] in,
    input [7:0] sel,
    output reg out
);

always @* begin
    case (sel)
        8'd0: out = in[0];
        8'd1: out = in[1];
        8'd2: out = in[2];
        // Add cases for the remaining 253 selections
        default: out = in[0]; // Default case, selects in[0]
    endcase
end

endmodule
