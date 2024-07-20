module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    // Define states
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;
    
    // State variables
    state_t state, next_state;
    
    // State transition logic (combinational)
    always @(*) begin
        case (state)
            A: next_state = (in) ? A : B;
            B: next_state = (in) ? B : A;
            default: next_state = B;
        endcase
    end
    
    // State update logic (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= B;
        end else begin
            state <= next_state;
        end
    end
    
    // Output logic (combinational)
    always @(*) begin
        out = (state == B);
    end
    
endmodule
