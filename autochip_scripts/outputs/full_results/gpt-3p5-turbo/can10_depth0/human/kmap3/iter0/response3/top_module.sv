module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);
    always @*
    begin
        case({a, b, c, d})
            4'b00xx: out = 1;
            4'b010x: out = 1;
            4'b011x: out = 1;
            4'b1xxx: out = 1;
            default:  out = 0;
        endcase
    end
endmodule
