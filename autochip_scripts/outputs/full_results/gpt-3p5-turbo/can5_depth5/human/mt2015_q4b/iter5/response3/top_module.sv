module top_module(
    input x,
    input y,
	output z
);

    reg z;

    always @(*) begin
        z = x & y;
    end

endmodule
