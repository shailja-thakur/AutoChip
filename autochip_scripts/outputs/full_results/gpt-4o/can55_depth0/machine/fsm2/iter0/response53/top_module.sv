module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State Encoding
    typedef enum logic [0:0] {
        A = 1'b0,
        B = 1'b1
    } state_t;
    
    // State and Next State Variables
    state_t state, next_state;

    // Combinational Logic for Next State
    always @(*) begin
        case (state)
            A: begin
                if (j) 
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (k)
                    next_state = A;
                else
                    next_state = B;
            end
            default: 
                next_state = A;
        endcase
    end

    // Sequential Logic for State Transition
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= A;
        else 
            state <= next_state;
    end

    // Output Logic
    always @(*) begin
        out = (state == B) ? 1'b1 : 1'b0;
    end

endmodule
