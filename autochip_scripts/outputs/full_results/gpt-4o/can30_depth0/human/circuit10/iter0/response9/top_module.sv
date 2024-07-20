module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        // Update the state and output based on input conditions
        if (a == 1'b1 && b == 1'b0) begin
            // If a is 1 and b is 0, set q to 1
            q <= 1'b1;
        end else if (a == 1'b1 && b == 1'b1) begin
            // If both a and b are 1, toggle q
            q <= ~q;
        end else if (b == 1'b1) begin
            // If just b is 1, set q to 0
            q <= 1'b0;
        end
        
        // Update state to be the same as q
        state <= q;
    end

endmodule
