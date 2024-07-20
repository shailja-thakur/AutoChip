module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    // State declaration
    typedef enum reg [2:0] {
        A, B, C, S10, S11, S20, S21, S22
    } state_type;
    
    state_type state, next_state;
    
    // State transition logic
    always @(*) begin
        case(state)
            A:    if (s) next_state = B;
                  else next_state = A;
            B:    if (w) next_state = S11;
                  else next_state = S10;
            C:    if (w) next_state = S11;
                  else next_state = S10;
            S10:  if (w) next_state = S21;
                  else next_state = S20;
            S11:  if (w) next_state = S22;
                  else next_state = S21;
            S20:  next_state = B;
            S21:  if (w) next_state = C;
                  else next_state = B;
            S22:  if (w) next_state = B;
                  else next_state = C;
            default: next_state = A; // Default state is A
        endcase
    end
    
    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Output logic - adjust as per requirement
    always @(*) begin
        case(state)
            S20, S22: z = 1; // Assuming output z is high for states S20 and S22
            default: z = 0;
        endcase
    end
    
endmodule
