module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // Define state encoding
    typedef enum logic [2:0] {
        A = 3'b000,  // Reset state
        B = 3'b001,  // Set f to 1 for one clock cycle
        C = 3'b010,  // Monitor x for sequence 1,0,1
        D = 3'b011,  // Set g to 1, monitor y
        E = 3'b100,  // g=1 permanently
        F = 3'b101   // g=0 permanently
    } state_t;
    
    state_t state, next_state;
    logic [1:0] x_history;
    logic [1:0] y_counter;

    // Sequential logic for state transitions and outputs
    always_ff @(posedge clk) begin
        if (!resetn) begin
            // Reset state
            state <= A;
            f <= 0;
            g <= 0;
            x_history <= 2'b00;
            y_counter <= 2'b00;
        end else begin
            state <= next_state;

            // Output logic
            if (state == B) begin
                f <= 1;
            end else begin
                f <= 0;
            end

            if (state == D && y == 1) begin
                g <= 1;
            end else if (state == E) begin
                g <= 1;
            end else if (state == F) begin
                g <= 0;
            end
        end
    end

    // Combinational logic for next state and counters
    always_comb begin
        next_state = state;
        case (state)
            A: begin
                if (resetn) begin
                    next_state = B;
                end
            end
            B: begin
                next_state = C;
            end
            C: begin
                x_history = {x_history[0], x};
                if (x_history == 2'b10 && x == 1) begin
                    next_state = D;
                end
            end
            D: begin
                y_counter = y_counter + 1;
                if (y == 1) begin
                    next_state = E;
                end else if (y_counter >= 2) begin
                    next_state = F;
                end
            end
            E: begin
                // Stay in state E where g=1 permanently
            end
            F: begin
                // Stay in state F where g=0 permanently
            end
            default: begin
                next_state = A;
            end
        endcase
    end

endmodule
