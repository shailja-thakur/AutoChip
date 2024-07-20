module top_module (
    input [3:0] a, 
    input [3:0] b, 
    input [3:0] c, 
    input [3:0] d,
    input [3:0] e,
    output reg [3:0] q
);

    always @(*) begin
        case(c)
            4'd0: q = b; // c == 0, q = b
            4'd1: q = e; // c == 1, q = e
            4'd2: q = a; // c == 2, q = a
            4'd3: q = d; // c == 3, q = d
            default: q = 4'hf; // c >= 4, q = f
        endcase
    end

endmodule
