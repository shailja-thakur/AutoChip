module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    // The state represents the output of the flip-flop from the previous state
    state <= q;
    
    // q is determined by the inputs a and b
    if (a == 1'b1 && b == 1'b1) begin
        q <= ~q; // Toggle q if both a and b are 1
    end
    else if (a == 1'b1 && b == 1'b0) begin
        q <= 1'b1; // Set q to 1 if a is 1 and b is 0
    end
    else if (a == 1'b0 && b == 1'b1) begin
        q <= 1'b0; // Set q to 0 if a is 0 and b is 1
    end
    // If a == 0 and b == 0, q remains unchanged
end

endmodule
