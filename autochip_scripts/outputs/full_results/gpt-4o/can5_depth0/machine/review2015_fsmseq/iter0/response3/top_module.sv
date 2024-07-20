module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    // Define state encoding
    typedef enum logic [2:0] {
        S     = 3'b000,
        S1    = 3'b001,
        S11   = 3'b010,
        S110  = 3'b011,
        DONE  = 3'b100
    } state_t;

    // Current state and next state variables
    state_t current_state, next_state;

    // Synchronous state transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= S;
        else
            current_state <= next_state;
    end
    
    // Combinational logic for state transition
    always @(*) begin
        case (current_state)
            S: begin
                if (data)
                    next_state = S1;
                else
                    next_state = S;
            end
            
            S1: begin
                if (data)
                    next_state = S11;
                else
                    next_state = S;
            end
            
            S11: begin
                if (data)
                    next_state = S11;
                else
                    next_state = S110;
            end
            
            S110: begin
                if (data)
                    next_state = DONE;
                else
                    next_state = S;
            end
            
            DONE: begin
                next_state = DONE;
            end
            
            default: begin
                next_state = S;
            end
        endcase
    end

    // Output logic
    always @(current_state) begin
        if (current_state == DONE)
            start_shifting = 1;
        else
            start_shifting = 0;
    end

endmodule
