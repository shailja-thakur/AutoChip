module top_module (
    input wire clock,
    input wire a,
    output reg p,
    output reg q
);

always @(negedge clock)
    q <= a;

always @*
begin
    if (clock)
        p <= a;
end

endmodule
