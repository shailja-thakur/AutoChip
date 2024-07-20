module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define the states using parameter
    typedef enum reg [1:0] {S_A = 2'b00, S_B = 2'b01, S_C = 2'b10, S_D = 2'b11} state_t;
    state_t state, next_state;

    // State register
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S_A;
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state
    always @(*) begin
        case (state)
            S_A: next_state = in ? S_B : S_A;
            S_B: next_state = in ? S_B : S_C;
            S_C: next_state = in ? S_D : S_A;
            S_D: next_state = in ? S_B : S_C;
            default: next_state = S_A;
        endcase
    end

    // Output logic
    always @(*) begin
        if (state == S_D)
            out = 1;
        else
            out = 0;
    end

endmodule
