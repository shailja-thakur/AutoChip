module top_module (
    input [7:0] in,
    output reg [2:0] pos
);
// Always block triggered whenever any of the inputs change
always @(in)
begin
    casez (in)
        // Cases to set the output port "pos" to a different 3-bit value
        8'bzzzzzzz1: pos <= 3'h0;
        8'bz1zzzzzz: pos <= 3'h6;
        // Default case to set the output port "pos" to the default value of 0
        default: pos <= 3'h0;
    endcase
end

endmodule
