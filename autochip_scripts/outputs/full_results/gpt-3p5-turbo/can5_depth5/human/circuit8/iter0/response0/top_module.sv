module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

always @(posedge clock) begin
    if (a) begin
        p <= 0;
        q <= 0;
    end else begin
        if (p) begin
            p <= 0;
        end else begin
            p <= 1;
        end
        
        if (q) begin
            q <= 0;
        end else begin
            q <= 1;
        end
    end
end

endmodule
