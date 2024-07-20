module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    // Define the states
    typedef enum reg [2:0] {
        S = 3'b000,
        S1 = 3'b001,
        S11 = 3'b011,
        S110 = 3'b010,
        Done = 3'b110
    } state_t;

    // State registers
    state_t current_state, next_state;

    // Sequential block: state transition on the clock's rising edge
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= S;  // On reset, go to initial state
        else
            current_state <= next_state;  // Otherwise, transition to next state
    end

    // Combinational block: determine the next state
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

    // Output logic: determine the output based on the current state
    always @(*) begin
        if (current_state == Done)
            start_shifting = 1;
        else
            start_shifting = 0;
    end

endmodule
