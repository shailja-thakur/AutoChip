module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @* begin
    case ({c, d, a, b})
        4'b00??: out = 1;
        4'b010?: out = 1;
        4'b011?: out = d;
        4'b100?: out = 0;
        4'b101?: out = 0;
        4'b110?: out = d;
        4'b111?: out = 1;
        default: out = 1;
    endcase
end

endmodule
