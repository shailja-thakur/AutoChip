module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    typedef enum reg [2:0] {A=3'b000, B=3'b001, C=3'b010, D=3'b011, E=3'b100, F=3'b101} state_t;
    state_t current_state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    always @(*) begin
        case(current_state)
            A: next_state = (w) ? A : B;
            B: next_state = (w) ? D : C;
            C: next_state = (w) ? D : E;
            D: next_state = (w) ? A : F;
            E: next_state = (w) ? D : E;
            F: next_state = (w) ? D : C;
            default: next_state = A;
        endcase
    end

    always @(*) begin
        case(current_state)
            E: z = 1;
            F: z = 1;
            default: z = 0;
        endcase
    end

endmodule
