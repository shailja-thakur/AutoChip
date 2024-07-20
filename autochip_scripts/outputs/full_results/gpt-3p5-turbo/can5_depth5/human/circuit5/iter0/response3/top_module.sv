module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

always @* begin
    case ({a, b, c, d, e})
        {4'b0000, 4'b1101}: q <= b; // 15ns
        {4'b0000, 4'b1110}: q <= e; // 20ns
        {4'b0000, 4'b1010}: q <= a; // 25ns
        {4'b0000, 4'b1100}: q <= d; // 30ns
        {4'b0000, 4'b1111}: q <= f; // 35ns onwards
        default: q <= f;
    endcase
end

endmodule
