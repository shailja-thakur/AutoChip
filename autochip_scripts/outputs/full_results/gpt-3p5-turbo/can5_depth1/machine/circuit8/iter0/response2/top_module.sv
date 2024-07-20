module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

// Register q is assigned the current value of signal a on the negative edge of the clock
always @(negedge clock) begin
    q <= a;
end

// Register p is assigned the current value of signal a if the clock signal is high
always @(posedge clock or a) begin
    if (clock) begin
        p <= a;
    end
end

endmodule
