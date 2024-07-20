module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // State encoding
    typedef enum logic [2:0] {
        A = 3'd0,
        B = 3'd1,
        C = 3'd2,
        D = 3'd3,
        E = 3'd4,
        F = 3'd5
    } state_t;

    state_t current_state, next_state;

    // State transition always block
    always_ff @(posedge clk or posedge reset) begin
        if (reset) 
            current_state <= A;
        else 
            current_state <= next_state;
    end

    // Next state logic always block
    always_comb begin
        case (current_state)
            A: next_state = (w) ? B : A;
            B: next_state = (w) ? C : D;
            C: next_state = (w) ? E : D;
            D: next_state = (w) ? F : A;
            E: next_state = (w) ? E : D;
            F: next_state = (w) ? C : D;
            default: next_state = A;
        endcase
    end

    // Output logic always block
    always_comb begin
        case (current_state)
            A: z = 1'b0;
            B: z = 1'b0;
            C: z = 1'b0;
            D: z = 1'b0;
            E: z = 1'b1;
            F: z = 1'b1;
            default: z = 1'b0;
        endcase
    end
    
endmodule
