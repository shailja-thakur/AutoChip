module top_module(
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    reg q2;

    always @(a or b or c or d) begin
        case({a, b, c, d})
            4'b0000: q2 = 1'b0;
            4'b0001: q2 = 1'b1;
            4'b0010: q2 = 1'b1;
            4'b0011: q2 = 1'b1;
            4'b0100: q2 = 1'b1;
            4'b0101: q2 = 1'b1;
            4'b0110: q2 = 1'b1;
            4'b0111: q2 = 1'b1;
            4'b1000: q2 = 1'b0;
            4'b1001: q2 = 1'b0;
            4'b1010: q2 = 1'b1;
            4'b1011: q2 = 1'b1;
            4'b1100: q2 = 1'b1;
            4'b1101: q2 = 1'b1;
            4'b1110: q2 = 1'b1;
            4'b1111: q2 = 1'b1;
            default: q2 = 1'b0;
        endcase
    end

    always @(posedge clk) begin
        q <= q2;
    end

endmodule
