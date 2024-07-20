module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // Define the state names using parameters
    typedef enum reg [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;

    // Declare the current state and next state variables
    state_t current_state, next_state;

    // Synchronize resetn
    always @(posedge clk) begin
        if (!resetn) begin
            current_state <= A;
            f <= 0;
            g <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    // State transition logic
    always @(*) begin
        // Default assignments
        next_state = current_state;
        f = 0;
        g = 0;
        
        case (current_state)
            A: begin
                if (resetn) begin
                    next_state = B;
                    f = 1;
                end
            end

            B: begin
                next_state = C;
            end

            C: begin
                if (x == 1) next_state = D;
            end

            D: begin
                if (x == 0) next_state = E;
                else next_state = C;
            end

            E: begin
                if (x == 1) next_state = F;
                else next_state = C;
            end

            F: begin
                g = 1;
                if (y == 1) next_state = F;
                else next_state = A;
            end

            default: next_state = A;
        endcase
    end

    // Output control
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            g <= 0;
        end else if (current_state == F) begin
            g <= 1;
        end else if (current_state == A) begin
            g <= 0;
        end
    end

endmodule
