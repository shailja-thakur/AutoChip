module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @(*)
begin
    case({a, b, c, d})
        4'b00?? : out = 1; // don't-care case
        4'b??0? : out = d; // don't-care case
        4'b??11 : out = 1; // don't-care case
        default : out = 0; // all other cases
    endcase
end

endmodule
