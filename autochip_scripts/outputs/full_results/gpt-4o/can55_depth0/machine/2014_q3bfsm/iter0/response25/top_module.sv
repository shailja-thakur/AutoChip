module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    // State declaration
    typedef enum reg [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100
    } state_t;

    state_t current_state, next_state;

    // State transition
    always @(*) begin
        case (current_state)
            A: if (x) next_state = B; else next_state = A;
            B: if (x) next_state = E; else next_state = B;
            C: if (x) next_state = B; else next_state = C;
            D: if (x) next_state = C; else next_state = B;
            E: if (x) next_state = E; else next_state = D;
            default: next_state = A;  // Default reset state
        endcase
    end

    // Sequential logic to update state and output
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;
            z <= 0;
        end else begin
            current_state <= next_state;
            z <= (current_state == D) || (current_state == E);
        end
    end
endmodule
