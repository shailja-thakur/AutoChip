module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    typedef enum reg [2:0] {
        S = 3'b000,
        S1 = 3'b001,
        S11 = 3'b010,
        S110 = 3'b011,
        Done = 3'b100
    } state_t;

    reg [2:0] state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            S: if (data) next_state = S1;
               else next_state = S;
            S1: if (data) next_state = S11;
                else next_state = S;
            S11: if (data) next_state = S11;
                 else next_state = S110;
            S110: if (data) next_state = Done;
                  else next_state = S;
            Done: next_state = Done;
            default: next_state = S;  // Default state
        endcase
    end

    // State register (sequential)
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= S;
        else 
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        if (state == Done)
            start_shifting = 1'b1;
        else
            start_shifting = 1'b0;
    end

endmodule
