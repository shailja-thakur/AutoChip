module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);

always @(*) begin
    if (a < b)
        if (a < c)
            if (a < d)
                min = a;
            else
                min = d;
        else
            if (c < d)
                min = c;
            else
                min = d;
    else
        if (b < c)
            if (b < d)
                min = b;
            else
                min = d;
        else
            if (c < d)
                min = c;
            else
                min = d;
end

endmodule
