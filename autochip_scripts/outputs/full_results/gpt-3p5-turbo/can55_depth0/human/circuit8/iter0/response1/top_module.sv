module top_module (
	input clock,
	input a,
	output reg p,
	output reg q
);
    always @(posedge clock) begin
        if (a) begin
            p <= q;
            q <= p;
        end else begin
            p <= p;
            q <= q;
        end
    end
endmodule
