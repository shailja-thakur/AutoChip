module top_module (
	input [7:0] in,
	output reg parity
);

always @(*)
begin
    if (in[0]^in[1]^in[2]^in[3]^in[4]^in[5]^in[6]^in[7] == 1'b1)
        parity = 1'b1;
    else
        parity = 1'b0;
end

endmodule
