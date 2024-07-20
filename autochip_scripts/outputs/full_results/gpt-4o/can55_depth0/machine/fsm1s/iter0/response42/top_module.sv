module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State declarations
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            A: if (in) next_state = A;
               else next_state = B;

            B: if (in) next_state = B;
               else next_state = A;

            default: next_state = A;
        endcase
    end

    // Sequential logic to update the state
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        if (state == B)
            out = 1'b1;
        else
            out = 1'b0;
    end

endmodule
