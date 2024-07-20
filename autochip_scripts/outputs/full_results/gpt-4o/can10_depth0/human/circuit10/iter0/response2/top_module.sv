module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    if (a == 1 && b == 1) begin
        q <= ~q;  // Toggle q when both a and b are 1
    end else if (a == 1 && b == 0) begin
        q <= 0;   // Reset q to 0 when a is 1 and b is 0
    end else if (a == 0 && b == 1) begin
        q <= 1;   // Set q to 1 when a is 0 and b is 1
    end else begin
        q <= q;   // Hold the value of q otherwise
    end
    state <= q;   // state tracks the output q
end

endmodule
