module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

// Assign q on negative edge of clock
always @(negedge clock) begin
    q <= a;
end

// Assign p when a changes and clock is high
always @(a) begin
    if (clock) begin
        p <= a;
    end
end

endmodule
