module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg state;

always @(posedge clock or negedge clock) begin
    if (clock) begin
        if (a) begin
            p <= 1;
        end
        else begin
            p <= 0;
        end 
    end else begin
        q <= (p | q) & ~a;
    end
end

endmodule
