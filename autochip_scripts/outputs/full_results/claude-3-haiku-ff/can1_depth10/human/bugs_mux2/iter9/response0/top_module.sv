module top_module (
    input sel,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out
);

    always @(*) begin
        case (sel)
            1'b0: out = a;
            1'b1: out = b;
            default: out = 'bx; // Updated default case to assign 'bx instead of 8'b0
        endcase
    end

endmodule
