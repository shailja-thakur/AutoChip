module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State Encoding
    typedef enum reg [1:0] {
        B = 2'b00,
        A = 2'b01
    } state_t;
    
    // State Registers
    state_t state, next_state;
    
    // State Transitions
    always @(*) begin
        case (state)
            B: if (in == 0) next_state = A;
               else next_state = B;
            A: if (in == 0) next_state = B;
               else next_state = A;
            default: next_state = B;  // Default state
        endcase
    end
    
    // Synchronous State and Output Update
    always @(posedge clk) begin
        if (reset) 
            state <= B;  // On reset go to state B
        else 
            state <= next_state;
    end
    
    // Output Logic (Moore machine output depends only on state, not input)
    always @(*) begin
        case (state)
            B: out = 1;
            A: out = 0;
            default: out = 1'bx;  // Undefined state
        endcase
    end

endmodule
