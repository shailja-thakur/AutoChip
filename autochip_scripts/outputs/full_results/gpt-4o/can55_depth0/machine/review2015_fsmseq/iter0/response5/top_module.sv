module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting);

    // State declaration
    typedef enum logic [2:0] {
        S    = 3'b000,
        S1   = 3'b001,
        S11  = 3'b010,
        S110 = 3'b011,
        Done = 3'b100
    } state_t;

    // State registers
    state_t current_state, next_state;

    // State transition logic (combinational)
    always_comb begin
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
            default: next_state = S;
        endcase
    end

    // State update logic (sequential)
    always_ff @(posedge clk or posedge reset) begin
        if (reset) 
            current_state <= S;
        else 
            current_state <= next_state;
    end

    // Output logic
    assign start_shifting = (current_state == Done);

endmodule
