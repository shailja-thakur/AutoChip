module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

reg Q;

always @(posedge clk) begin
    if (E) begin
        if (L)
            Q <= R;
        else
            Q <= Q;
    end
    else begin
        if (L)
            Q <= w;
        else
            Q <= Q;
    end
end

endmodule
