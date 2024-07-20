module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @(*) begin
    case({a,b,c,d})
        4'b00?? : out = 1;
        4'b0101, 4'b0110, 4'b0111 : out = 1;
        default : out = 0;
    endcase
end

endmodule
