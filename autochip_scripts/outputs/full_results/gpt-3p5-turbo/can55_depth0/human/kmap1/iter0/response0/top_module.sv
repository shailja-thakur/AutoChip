module top_module(
    input a,
    input b,
    input c,
    output out
);

	reg out;

	always@(a or b or c)
		begin
			case({a,b,c})
				0: out <= 0;
				1: out <= 1;
				3: out <= 1;
				default: out <= 1;
			endcase
		end

endmodule
