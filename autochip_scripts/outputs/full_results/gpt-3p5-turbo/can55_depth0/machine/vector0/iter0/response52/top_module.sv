module top_module(
	input [2:0] vec, 
	output reg [2:0] outv,
	output reg o2,
	output reg o1,
	output reg o0
);

always @(vec)
begin
    outv <= vec;
    o2 <= vec[2];
    o1 <= vec[1];
    o0 <= vec[0];
end

endmodule
