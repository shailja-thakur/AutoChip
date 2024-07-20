module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

reg temp;

always @(negedge clock)
    q <= a;

always @(a)
begin
    if (clock == 1)
        p <= a;
end

endmodule
