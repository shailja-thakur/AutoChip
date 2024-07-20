module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    reg [2:0] state, next_state;
    reg [2:0] x_seq;
    reg [1:0] y_timer;
    reg [1:0] y_check_timer;

    // State encoding
    localparam [2:0] A = 3'b000,
                     B = 3'b001,
                     C = 3'b010,
                     D = 3'b011,
                     E = 3'b100,
                     F = 3'b101;

    // State transition
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= A;
            x_seq <= 3'b000;
            y_timer <= 2'b00;
            f <= 1'b0;
            g <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and outputs
    always @(*) begin
        case (state)
            A: begin
                f = 1'b0;
                g = 1'b0;
                next_state = (resetn) ? A : B;
            end

            B: begin
                f = 1'b1;
                g = 1'b0;
                next_state = C;
            end

            C: begin
                f = 1'b0;
                g = 1'b0;
                next_state = (x_seq == 3'b101) ? D : C;
            end

            D: begin
                f = 1'b0;
                g = 1'b1;
                y_check_timer = 2'b00;
                next_state = E;
            end

            E: begin
                f = 1'b0;
                g = 1'b1;
                if (y == 1'b1)
                    next_state = F;
                else if (y_check_timer == 2'b10)
                    next_state = A;
                else
                    next_state = E;
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
            x_seq <= 3'b000;
        end else if (state == C) begin
            x_seq <= {x_seq[1:0], x};
        end else begin
            x_seq <= 3'b000;
        end
    end

    // Monitoring y input with a timer for 2 cycles
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            y_check_timer <= 2'b00;
        end else if (state == E && y != 1'b1) begin
            y_check_timer <= y_check_timer + 1;
        end else begin
            y_check_timer <= 2'b00;
        end
    end

endmodule
