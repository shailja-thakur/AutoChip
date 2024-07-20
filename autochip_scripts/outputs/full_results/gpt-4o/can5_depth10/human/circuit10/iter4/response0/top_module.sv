module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    reg next_state;

    always @(posedge clk) begin
        state <= next_state;  // Update state on rising edge of clk
    end

    always @(*) begin
        // Determine next state based on inputs a and b
        if (a == 1'b1) begin
            next_state = b;
        end else begin
            next_state = state;
        end
    end

    always @(*) begin
        q = state;  // `q` is the current state
    end

endmodule
