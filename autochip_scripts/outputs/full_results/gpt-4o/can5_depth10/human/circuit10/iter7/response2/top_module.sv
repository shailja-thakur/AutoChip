module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    reg next_state;

    always @(posedge clk) begin
        // State transition logic
        if (a == 1 && b == 1)
            next_state <= ~state;
        else
            next_state <= state;

        state <= next_state;
    end

    always @(posedge clk) begin
        // Update output q based on state
        q <= (state == 1) ? b : a;
    end
    
endmodule
