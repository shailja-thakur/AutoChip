module top_module (
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    input [3:0] e,
    output reg [3:0] q
);
    always @(*) begin
        case (c)
            4'b0000: q = b;
            4'b0001: q = e;
            4'b0010: q = a;
            4'b0011: q = d;
            default: q = 4'b1111; // 'f' was displayed after c=3, values from 4 to f: undefined behavior, assigning unknown 'f' state (1111)
        endcase
    end
endmodule
