module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    reg state, next_state;
    localparam A = 0;
    localparam B = 1;

    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = B;  // Should not happen, but good practice
        endcase
    end

    // State register with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            A: out = 0;
            B: out = 1;
        endcase
    end

endmodule
