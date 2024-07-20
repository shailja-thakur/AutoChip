module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State encoding
    typedef enum logic [3:0] {
        A = 4'b0000,
        B = 4'b0001,
        X1 = 4'b0010,
        X0 = 4'b0011,
        X1_2 = 4'b0100,
        G1 = 4'b0101,
        Y_WAIT1 = 4'b0110,
        Y_WAIT2 = 4'b0111,
        PERM_G1 = 4'b1000,
        PERM_G0 = 4'b1001
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk or negedge resetn) begin
        if (~resetn)
            current_state <= A;
        else
            current_state <= next_state;
    end

    always_comb begin
        next_state = current_state;
        f = 0;
        g = 0;

        case (current_state)
            A: begin
                if (~resetn)
                    next_state = A;
                else
                    next_state = B;
            end
            B: begin
                f = 1;
                next_state = X1;
            end
            X1: begin
                if (x)
                    next_state = X0;
                else
                    next_state = X1;
            end
            X0: begin
                if (~x)
                    next_state = X1_2;
                else
                    next_state = X1;
            end
            X1_2: begin
                if (x) begin
                    g = 1;
                    next_state = G1;
                end else
                    next_state = X1;
            end
            G1: begin
                g = 1;
                next_state = Y_WAIT1;
            end
            Y_WAIT1: begin
                g = 1;
                if (y)
                    next_state = PERM_G1;
                else
                    next_state = Y_WAIT2;
            end
            Y_WAIT2: begin
                g = 1;
                if (y)
                    next_state = PERM_G1;
                else
                    next_state = PERM_G0;
            end
            PERM_G1: begin
                g = 1;
                next_state = PERM_G1;
            end
            PERM_G0: begin
                g = 0;
                next_state = PERM_G0;
            end
        endcase
    end
endmodule
