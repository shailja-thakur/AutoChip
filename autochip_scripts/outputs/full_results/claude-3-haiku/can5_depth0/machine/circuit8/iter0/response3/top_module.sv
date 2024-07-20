module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

// Handle the negative edge of the clock
always @(negedge clock) begin
    q <= a;
end

// Handle changes in the input signal a
always @(a) begin
    if (clock) begin
        p <= a;
    end
end

endmodule
