module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

always @(in)
begin
    casez(in)
        8'bzzzzzzz0: pos <= 3'b0;
        8'bzzzzzzz1: pos <= 3'b1;
        8'bzzzzzz10: pos <= 3'b2;
        8'bzzzzzz11: pos <= 3'b3;
        8'bzzzzz100: pos <= 3'b4;
        8'bzzzzz101: pos <= 3'b5;
        8'bzzzzz110: pos <= 3'b6;
        8'bzzzzz111: pos <= 3'b7;
        default: pos <= 3'b0;
    endcase
end

endmodule
