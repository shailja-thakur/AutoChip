module top_module (
	input [7:0] in,
	output reg [31:0] out
);

always @* begin
    out = {24{in}, in};
end

endmodule
