module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // Define the states for the FSM
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;

    // State registers
    state_t current_state, next_state;

    // Combinational always block to determine the next state
    always @(*) begin
        case (current_state)
            A: if (j) next_state = B; else next_state = A;
            B: if (k) next_state = A; else next_state = B;
            default: next_state = A;
        endcase
    end

    // Clocked always block to update the current state
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    // Assign the output based on the current state
    always @(*) begin
        out = (current_state == B);
    end

endmodule
