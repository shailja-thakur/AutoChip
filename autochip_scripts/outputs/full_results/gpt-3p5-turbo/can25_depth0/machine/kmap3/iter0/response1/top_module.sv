module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);
    
always @(*) begin
    case ({a, b, c, d})
        4'b0000, 4'b0001, 4'b0101, 4'b0110, 4'b0111:
            out = 1'b0;
        4'b0011, 4'b0010, 4'b1100, 4'b1011:
            out = 1'b1;
        4'b0100, 4'b1001, 4'b1010, 4'b1000:
            out = 1'bx;
        default:
            out = 1'b1;
    endcase
end

endmodule
