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

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: if (w) next_state = A; else next_state = B;
            B: if (w) next_state = D; else next_state = C;
            C: if (w) next_state = D; else next_state = E;
            D: if (w) next_state = A; else next_state = F;
            E: if (w) next_state = D; else next_state = E;
            F: if (w) next_state = D; else next_state = C;
            default: next_state = A;
        endcase
    end

    // State flip-flops
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= A;
        else 
            state <= next_state;
    end

    // Output logic for z
    always @(*) begin
        case (state)
            E: z = 1;
            F: z = 1;
            default: z = 0;
        endcase
    end

endmodule
