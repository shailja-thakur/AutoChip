module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

// Define the states of the FSM
typedef enum {A, B, C, D, E} state_t;
state_t state, next_state;

// State update logic
always @(posedge clk, negedge resetn) begin
    if (!resetn) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

// Next state and output logic
always @(*) begin
    next_state = state;
    f = 0;
    g = 0;

    case (state)
        A: begin
            if (resetn) begin
                next_state = B;
                f = 1;
            end
        end
        B: begin
            if (x == 1 && next_state == B) begin
                next_state = C;
            end else if (x == 0 && next_state == C) begin
                next_state = D;
            end else if (x == 1 && next_state == D) begin
                next_state = E;
                g = 1;
            end
        end
        C: begin
            if (y == 1) begin
                g = 1;
            end else if (y == 0 && next_state == C) begin
                g = 0;
            end
        end
        D: begin
            if (y == 1) begin
                g = 1;
            end else if (y == 0 && next_state == D) begin
                g = 0;
            end
        end
        E: begin
            // Maintain g = 1 until reset
        end
    endcase
end

endmodule
