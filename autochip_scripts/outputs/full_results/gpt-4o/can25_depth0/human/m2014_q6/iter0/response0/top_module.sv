module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // State encoding
    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;

    state_t state, next_state;

    // State transitions
    always @(*) begin
        case (state)
            A: begin
                if (w == 1'b0) next_state = B;
                else           next_state = A;
            end
            B: begin
                if (w == 1'b0) next_state = C;
                else           next_state = D;
            end
            C: begin
                if (w == 1'b0) next_state = E;
                else           next_state = D;
            end
            D: begin
                if (w == 1'b0) next_state = F;
                else           next_state = A;
            end
            E: begin
                if (w == 1'b0) next_state = E;
                else           next_state = D;
            end
            F: begin
                if (w == 1'b0) next_state = C;
                else           next_state = D;
            end
            default: begin
                next_state = A;
            end
        endcase
    end

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= A;
        else 
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            A, B, C, D: z = 1'b0;
            E, F:       z = 1'b1;
            default:    z = 1'b0;
        endcase
    end

endmodule
