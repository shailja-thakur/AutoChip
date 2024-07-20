module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // State encoding
    typedef enum reg [2:0] {
        S = 3'b000,
        S1 = 3'b001,
        S11 = 3'b010,
        S110 = 3'b011,
        Done = 3'b100
    } state_t;
    
    state_t state, next_state;

    // State update logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
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
            Done: next_state = Done;
            default: next_state = S;  // Default to initial state
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            start_shifting <= 1'b0;
        else if (state == Done)
            start_shifting <= 1'b1;
        else
            start_shifting <= 1'b0;
    end

endmodule
