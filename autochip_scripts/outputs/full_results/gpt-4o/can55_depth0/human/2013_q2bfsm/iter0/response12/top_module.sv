module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum { A, B, C, D, E, F, G, H } state_t; // states of the FSM
    state_t state, next_state;
    reg [1:0] y_timer; // counter to monitor y within two clock cycles

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state; // default state is the current state
        f = 0;
        g = 0;

        case(state)
            A: begin
                if (resetn) 
                    next_state = B; // Move to state B when reset is de-asserted
            end
            B: begin
                f = 1;
                next_state = C;
            end
            C: begin
                if (x == 1)
                    next_state = D;
            end
            D: begin
                if (x == 0)
                    next_state = E;
            end
            E: begin
                if (x == 1)
                    next_state = F;
            end
            F: begin
                g = 1;
                next_state = G;
            end
            G: begin
                g = 1;
                if (y == 1) 
                    next_state = H; // y detected within the allowed time
                else if (y_timer == 2) 
                    next_state = A; // y not detected within 2 cycles, reset FSM
                else
                    next_state = G;
            end
            H: begin
                g = 1;
            end
            default: begin
                next_state = A;
            end
        endcase
    end
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            y_timer <= 0;
        end else if (state == G) begin
            y_timer <= y_timer + 1;
        end else begin
            y_timer <= 0;
        end
    end

endmodule
