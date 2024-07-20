module top_module (
    input [99:0] a,
    input [99:0] b,
    input sel,
    output [99:0] out
);

always @(*) begin
    case (sel)
        1'b0: out = a;
        1'b1: out = b;
        default: out = {100{1'b0}}; // Set output to 0 for any other value of sel
    endcase
end

endmodule
