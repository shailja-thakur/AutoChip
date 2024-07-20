module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum reg [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;

    state_t state, next_state;
    reg [1:0] x_seq;
    reg [1:0] y_timer;

    // State transition
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= A;
            f <= 1'b0;
            g <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                f = 1'b0;
                g = 1'b0;
                if (resetn == 1'b1)
                    next_state = B;
                else
                    next_state = A;
            end

            B: begin
                f = 1'b1; // Set 'f' to 1 for one clock cycle
                g = 1'b0;
                next_state = C;
            end

            C: begin
                f = 1'b0;
                g = 1'b0;
                next_state = C;
                if (x == 1'b1 && x_seq == 2'b10)
                    next_state = D;
            end

            D: begin
                f = 1'b0;
                g = 1'b1;
                next_state = E;
                y_timer = 2'b00; // start monitoring y
            end

            E: begin
                f = 1'b0;
                g = 1'b1;
                if(y == 1'b1)
                    next_state = F;
                else if(y_timer < 2'b01)
                    y_timer = y_timer + 1;
                else
                    next_state = A; // Transition back to initial state if y doesn't become 1 in 2 cycles
            end

            F: begin
                f = 1'b0;
                g = 1'b1;
                next_state = F;
            end

            default: begin
                f = 1'b0;
                g = 1'b0;
                next_state = A;
            end
        endcase
    end

    // Monitoring x input for sequence 1, 0, 1
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            x_seq <= 2'b00;
        end else if (state == C) begin
            x_seq <= {x_seq[0], x};
        end else begin
            x_seq <= 2'b00;
        end
    end

    // Monitoring y input with a timer for 2 cycles
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            y_timer <= 2'b00;
        end else if (state == E && y != 1'b1) begin
            y_timer <= y_timer + 1;
        end else begin
            y_timer <= 2'b00;
        end
    end

endmodule
