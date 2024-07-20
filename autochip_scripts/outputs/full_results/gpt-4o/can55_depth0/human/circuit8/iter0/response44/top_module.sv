module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

always @(posedge clock) begin
    if (a == 1) begin
        p <= 1;
    end else begin
        p <= 0;
    end
end

always @(negedge clock) begin
    if (a == 1 && p == 1) begin
        q <= 1;
    end else begin
        q <= 0;
    end
end

endmodule
