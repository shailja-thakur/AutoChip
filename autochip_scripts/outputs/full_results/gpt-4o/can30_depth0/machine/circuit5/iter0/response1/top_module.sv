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
            4'b0000: q = b; // if c is 0
            4'b0001: q = e; // if c is 1
            4'b0010: q = a; // if c is 2
            4'b0011: q = d; // if c is 3
            default: q = 4'hF; // if c is any other value
        endcase
    end

endmodule
