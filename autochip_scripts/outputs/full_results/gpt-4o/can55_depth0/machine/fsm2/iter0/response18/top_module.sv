module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // Define state constants
    typedef enum logic [1:0] {
        A = 1'b0,
        B = 1'b1
    } state_t;

    state_t current_state, next_state;
    
    // Combinational logic to determine next state
    always @(*) begin
        case (current_state)
            A: next_state = j ? B : A;
            B: next_state = k ? A : B;
            default: next_state = A;
        endcase
    end

    // Synchronous logic to update state
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        out = (current_state == B);
    end

endmodule
