module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define states using a localparam
    localparam A = 1'b0, B = 1'b1;
    reg state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: if (in) next_state = A;
                else next_state = B;
            B: if (in) next_state = B;
                else next_state = A;
            default: next_state = A;
        endcase
    end

    // State update and reset logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B;
        else
            state <= next_state;
    end

    // Output logic
    always @(state) begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b0;
        endcase
    end
endmodule
