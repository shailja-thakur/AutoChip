module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // Define the states
    typedef enum reg [2:0] {
        S = 3'b000,
        S1 = 3'b001,
        S11 = 3'b010,
        S110 = 3'b011,
        Done = 3'b100
    } state_t;

    // Define state register
    state_t state, next_state;

    // State transition logic (combinational logic)
    always @(*) begin
        case (state)
            S:    next_state = data ? S1 : S;
            S1:   next_state = data ? S11 : S;
            S11:  next_state = data ? S11 : S110;
            S110: next_state = data ? Done : S;
            Done: next_state = Done;
            default: next_state = S;
        endcase
    end

    // State register (sequential logic)
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= S;
        else 
            state <= next_state;
    end

    // Output logic (combinational logic)
    always @(*) begin
        case (state)
            Done: start_shifting = 1;
            default: start_shifting = 0;
        endcase
    end

endmodule
