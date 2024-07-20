module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);
    // Define states
    typedef enum logic [2:0] {
        S     = 3'b000,
        S1    = 3'b001,
        S11   = 3'b010,
        S110  = 3'b011,
        Done  = 3'b100
    } state_t;

    // State register
    state_t current_state, next_state;

    // Update state on clock or reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= S;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic to determine the next state
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
                    next_state = Done;
                else
                    next_state = S;
            end
            Done: begin
                next_state = Done;
            end
            default: begin
                next_state = S;
            end
        endcase
    end

    // Output logic based on current state
    always @(*) begin
        if (current_state == Done) 
            start_shifting = 1;
        else
            start_shifting = 0;
    end

endmodule
