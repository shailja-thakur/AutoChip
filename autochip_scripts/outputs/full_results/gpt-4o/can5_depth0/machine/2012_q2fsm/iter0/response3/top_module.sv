module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // State representation
    typedef enum logic [2:0] {
        A = 3'd0,
        B = 3'd1,
        C = 3'd2,
        D = 3'd3,
        E = 3'd4,
        F = 3'd5
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic (combinational)
    always @(*) begin
        case (state)
            A: next_state = (w ? B : A);
            B: next_state = (w ? C : D);
            C: next_state = (w ? E : D);
            D: next_state = (w ? F : A);
            E: next_state = (w ? E : D);
            F: next_state = (w ? C : D);
        endcase
    end
    
    // State register logic (sequential)
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        z = (state == E || state == F);
    end

endmodule
