module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

// Implement the following logic based on the given simulation waveforms:
// When clock is 0 and a is 0, p and q are 0.
// When clock is 1 and a is 0, p is 0 and q remains unchanged.
// When clock is 1 and a is 1, p is 1 and q becomes 0.
// When clock is 0 and a is 1, p becomes 0 and q becomes 1.

always @(posedge clock) begin
    if (a == 0) begin
        p <= 0;
    end
    else begin
        p <= 1;
    end
end

always @(negedge clock) begin
    if (a == 0) begin
        q <= q;
    end
    else begin
        q <= 0;
    end
end

endmodule
