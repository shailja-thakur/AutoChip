module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // Define states
    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;
    
    state_t state, next_state;
    reg [1:0] y_count;  // Counter to check y within two cycles

    // Synchronous reset and state transition
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= A;
            y_count <= 0;
        end else begin
            state <= next_state;
            if (state == E) begin
                if (y_count < 2)
                    y_count <= y_count + 1;
            end else begin
                y_count <= 0;
            end
        end
    end

    // Next state logic and output logic
    always @(*) begin
        // Default assignments
        next_state = state;
        f = 0;
        g = 0;
        
        case(state)
            A: begin
                if (resetn) begin
                    next_state = B;
                    f = 1;  // Set f to 1 for one clock cycle when moving out of state A
                end
            end
            B: begin
                if (x)
                    next_state = C;
            end
            C: begin
                if (!x)
                    next_state = D;
                else
                    next_state = B;
            end
            D: begin
                if (x)
                    next_state = E;
                else
                    next_state = B;  // Return to state B to restart the sequence
            end
            E: begin
                g = 1;  // Set g to 1 when in state E
                if (y) begin
                    next_state = F;
                end else if (y_count >= 2) begin
                    next_state = A;
                end
            end
            F: begin
                g = 1;  // Maintain g = 1 permanently
                // Remain in state F until reset
            end
            default: begin
                next_state = A;
            end
        endcase
    end
endmodule
