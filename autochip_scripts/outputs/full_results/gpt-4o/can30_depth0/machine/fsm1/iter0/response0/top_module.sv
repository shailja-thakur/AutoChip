module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // State transition 
    always @(*) begin
        case (state)
            A: next_state = (in == 1'b1) ? A : B;
            B: next_state = (in == 1'b1) ? B : A;
            default: next_state = B;
        endcase
    end
    
    // State update
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        out = (state == B) ? 1'b1 : 1'b0;
    end

endmodule
