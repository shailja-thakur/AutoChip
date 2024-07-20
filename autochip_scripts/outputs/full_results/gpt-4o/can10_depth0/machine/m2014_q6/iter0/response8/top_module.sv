module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // State encoding
    typedef enum reg [2:0] {
        A = 3'd0,
        B = 3'd1,
        C = 3'd2,
        D = 3'd3,
        E = 3'd4,
        F = 3'd5
    } state_t;
    
    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            A: next_state = (w == 1'b0) ? B : A;
            B: next_state = (w == 1'b1) ? D : C;
            C: next_state = (w == 1'b1) ? D : E;
            D: next_state = (w == 1'b1) ? A : F;
            E: next_state = (w == 1'b1) ? D : E;
            F: next_state = (w == 1'b1) ? D : C;
            default: next_state = A;   // Default to A to handle unexpected cases
        endcase
    end

    // State update logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (current_state)
            E: z = 1'b1;
            F: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
