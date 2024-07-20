module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        // Updating state based on the inputs a and b
        if (a == 1 && b == 1) begin
            state <= ~state; // Toggling state when both a and b are 1
        end else if (a == 1 && b == 0) begin
            state <= 0; // Resetting state when a is 1 and b is 0
        end else if (a == 0 && b == 1) begin
            state <= state; // Retaining state when a is 0 and b is 1
        end else begin
            state <= state; // Retaining state when both a and b are 0
        end
        
        // Updating q to be the current state
        q <= state;
    end

endmodule
