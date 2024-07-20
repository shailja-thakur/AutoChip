module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);
    always@(a or b or c or d) begin
        case({c, d, a ,b})
            4'b00xx : out = 1;
            4'b0101 : out = 0;
            4'b1001 : out = 0;
            4'b1011 : out = 0;
            4'b1111 : out = 1;
            default : out = 1;
        endcase
    end
endmodule
