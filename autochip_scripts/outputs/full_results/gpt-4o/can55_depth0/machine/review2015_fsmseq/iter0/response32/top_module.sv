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
    
    // Register to hold the current state
    reg [2:0] state, next_state;
    
    // State transitions based on current state and data input
    always @(*) begin
        case (state)
            S:    next_state = (data) ? S1 : S;
            S1:   next_state = (data) ? S11 : S;
            S11:  next_state = (data) ? S11 : S110;
            S110: next_state = (data) ? Done : S;
            Done: next_state = Done;
            default: next_state = S;
        endcase
    end
    
    // State flip-flops with synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S;
        end else begin
            state <= next_state;
        end
    end
    
    // Output logic based on current state
    always @(*) begin
        start_shifting = (state == Done);
    end

endmodule
