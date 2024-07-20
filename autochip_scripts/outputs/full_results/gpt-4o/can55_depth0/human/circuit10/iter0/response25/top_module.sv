module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    state <= q; // state reflects the current output of the flip-flop

    if (a && b) begin
        q <= ~q; // Toggle q if both a and b are high
    end else if (a && !b) begin
        q <= 1; // Set q to 1 if a is high and b is low
    end else if (!a && b) begin
        q <= 0; // Set q to 0 if a is low and b is high
    end else begin
        // Retain the previous state of q if both a and b are low
    end
end

endmodule
