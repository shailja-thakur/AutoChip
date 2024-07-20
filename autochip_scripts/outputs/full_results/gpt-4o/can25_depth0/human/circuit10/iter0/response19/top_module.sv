module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        // Update the state based on inputs a and b
        // State switches when either (a == 1 and b == 1) or (a == 0 and b == 1)
        if ((a == 1'b1 && b == 1'b1) || (a == 1'b0 && b == 1'b1)) begin
            state <= ~state;
        end

        // Update the output q to follow the state
        q <= state;
    end

endmodule
