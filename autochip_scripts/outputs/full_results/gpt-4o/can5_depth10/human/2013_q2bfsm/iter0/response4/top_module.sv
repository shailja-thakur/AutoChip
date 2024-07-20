module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum reg [2:0] {
        A,  // Initial state
        B,  // Output f=1 for one cycle
        C,  // Monitoring x
        D,  // 101 sequence detected, set g=1
        E,  // Check y within 2 cycles
        F,  // y=1 within 2 cycles, maintain g=1
        G   // y not 1 within 2 cycles, set g=0
    } state_t;
    
    state_t state, next_state;
    reg [1:0] y_counter;
    reg [2:0] x_seq;  // History register to save the last three values of x
    
    // Sequential state transition
    always @(posedge clk) begin
        if (~resetn) begin
            state <= A;
            x_seq <= 3'b000;
            y_counter <= 0;
        end else begin
            state <= next_state;
        end
    end
    
    // Outputs and next state logic
    always @(*) begin
        // Default outputs
        f = 0;
        g = 0;

        // Default next state
        next_state = state;

        case (state)
            A: begin
                if (~resetn) begin
                    next_state = A;
                end else begin
                    next_state = B;  // Move to state B in the next clock
                end
            end
            
            B: begin
                f = 1;  // Set f=1 for one clock cycle
                next_state = C;
            end

            C: begin
                x_seq = {x_seq[1:0], x};  // Shift in the new x value
                if (x_seq == 3'b101) begin
                    next_state = D;  // Detected 101 in the sequence
                end else begin
                    next_state = C;  // Stay in state C
                end
            end

            D: begin
                g = 1;  // Set g=1
                next_state = E;  // Move to state E for checking y
            end

            E: begin
                g = 1;  // Maintain g=1
                if (y) begin
                    next_state = F;  // y=1 detected within the window
                end else if (y_counter == 2) begin
                    next_state = G;  // Window expired without y=1
                end
            end

            F: begin
                g = 1;  // Maintain g=1 permanently
                next_state = F;  // Stay in state F
            end

            G: begin
                g = 0;  // Set g=0 permanently
                next_state = G;  // Stay in state G
            end

            default: next_state = A;
        endcase
    end

    // Counter logic
    always @(posedge clk) begin
        if ((state == E) && ~resetn) begin
            y_counter <= 0;
        end else if (state == E) begin
            y_counter <= y_counter + 1;
        end else begin
            y_counter <= 0;
        end
    end

endmodule
