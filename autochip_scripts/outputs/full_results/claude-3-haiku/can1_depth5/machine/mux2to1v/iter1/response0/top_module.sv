module top_module (
    input [99:0] a,
    input [99:0] b,
    input sel,
    output reg [99:0] out
);

always @(*) begin
    case (sel)
        1'b0: out = a;
        1'b1: out = b;
        default: out = {100{1'bx}}; // Set the output to an unknown value if the select signal is invalid
    endcase
end

endmodule
