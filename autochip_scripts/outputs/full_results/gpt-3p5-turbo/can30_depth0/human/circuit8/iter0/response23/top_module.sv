module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg prev_a;
reg prev_p;

always @(posedge clock) begin
    prev_a <= a;
end

always @(posedge clock) begin
    if (a == 1'b1 && prev_a == 1'b0) begin
        p <= ~p;
        q <= ~q;
    end
end

endmodule
