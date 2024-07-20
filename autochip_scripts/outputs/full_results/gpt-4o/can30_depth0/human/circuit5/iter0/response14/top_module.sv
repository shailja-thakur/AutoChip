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
            4'b0000: q = b;  // c == 0
            4'b0001: q = e;  // c == 1
            4'b0010: q = a;  // c == 2
            4'b0011: q = d;  // c == 3
            default: q = 4'b1111;  // c >= 4
        endcase
    end

endmodule
