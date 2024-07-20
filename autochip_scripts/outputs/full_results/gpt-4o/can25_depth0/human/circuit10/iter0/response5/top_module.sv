module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);
    // Flip-flop to hold the state
    reg flip;

    always @(posedge clk) begin
        // Determine the next state of the flip-flop
        if (a) begin
            if (b) begin
                flip <= ~flip;
            end
        end else begin
            flip <= b;
        end

        // Output q mirrors flip value
        q <= flip;
        state <= flip;
    end
endmodule
