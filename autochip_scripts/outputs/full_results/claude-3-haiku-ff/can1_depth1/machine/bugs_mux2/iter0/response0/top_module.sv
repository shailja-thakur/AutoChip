module top_module (
    input sel,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out
);

always @(*) begin
    case (sel)
        1'b0: out = b;
        1'b1: out = a;
        default: out = 'b0; // Assign a default value to 'out' in case 'sel' is not 0 or 1
    endcase
end

endmodule
