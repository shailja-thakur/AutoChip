module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    // State declaration
    typedef enum reg [1:0] {A = 1'b0, B = 1'b1} state_t;
    state_t state, next_state;
    
    // Combinational always block to determine next state
    always @(*) begin
        case (state)
            A: next_state = j ? B : A;
            B: next_state = k ? A : B;
            default: next_state = A;
        endcase
    end
    
    // Clocked always block for state transition and reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end
    
    // Output logic
    always @(state) begin
        out = (state == B);
    end

endmodule
