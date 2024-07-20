module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State declarations
    typedef enum reg [1:0] {
        B = 2'b00,
        A = 2'b01
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= B;
        else 
            state <= next_state;
    end
    
    // Next state and output logic
    always @(*) begin
        case (state)
            B: begin
                out = 1;
                if (in)
                    next_state = B;
                else
                    next_state = A;
            end
            A: begin
                out = 0;
                if (in)
                    next_state = A;
                else
                    next_state = B;
            end
            default: begin
                next_state = B;
                out = 1; // default output for reset state
            end
        endcase
    end
    
endmodule
