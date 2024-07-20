module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    // State encoding
    typedef enum logic [2:0] {
        S   = 3'b000,
        S1  = 3'b001,
        S11 = 3'b010,
        S110 = 3'b011,
        Done = 3'b100
    } state_t;

    state_t state, next_state;

    // State transition logic (combinational)
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
            Done: begin
                next_state = Done;
            end
            default: next_state = S; // default state
        endcase
    end

    // State register (sequential)
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S;
        else
            state <= next_state;
    end

    // Output logic (combinational)
    always @(*) begin
        if (state == Done)
            start_shifting = 1;
        else
            start_shifting = 0;
    end

endmodule
