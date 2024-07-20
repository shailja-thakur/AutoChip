module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

always @(in) begin
    casez(in)
        8'bzzzzzzz1: pos <= 3'b0;
        8'b1zzzzzzz: pos <= 3'b6;
        // add more cases here
        
        default: pos <= 3'b0;
    endcase
end

endmodule
