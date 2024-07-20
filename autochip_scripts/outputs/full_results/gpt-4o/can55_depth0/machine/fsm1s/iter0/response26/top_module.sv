module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State declarations
    typedef enum reg [1:0] { 
        A = 2'b00, 
        B = 2'b01 
    } state_t;
    
    state_t state, next_state;

    // Combinational logic block to determine next state
    always @(*) begin
        case (state)
            A: next_state = (in) ? A : B;
            B: next_state = (in) ? B : A;
            default: next_state = B;  // Default state after reset
        endcase
    end

    // Sequential block to update state on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= B;  // Reset to state B
        else 
            state <= next_state;  // Update state
    end

    // Output logic
    always @(state) begin
        out = (state == B) ? 1'b1 : 1'b0;
    end

endmodule
