module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    reg [2:0] state, next_state;
    reg [1:0] x_seq;
    reg [1:0] y_timer;

    // State encoding
    localparam [2:0] A = 3'b000,
                     B = 3'b001,
                     C = 3'b010,
                     D = 3'b011,
                     E = 3'b100,
                     F = 3'b101;

    // Synchronous state transition and output assignment
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= A;
            x_seq <= 2'b00;
            y_timer <= 2'b00;
            f <= 1'b0;
            g <= 1'b0;
        end else begin
            state <= next_state;

            // Updating outputs based on state
            case (next_state)
                A: begin
                    f <= 1'b0;
                    g <= 1'b0;
                end
                B: begin
                    f <= 1'b1;
                    g <= 1'b0;
                end
                C: begin
                    f <= 1'b0;
                    g <= 1'b0;
                end
                D: begin
                    f <= 1'b0;
                    g <= 1'b1;
                end
                E: begin
                    f <= 1'b0;
                    g <= 1'b1;
                end
                F: begin
                    f <= 1'b0;
                    g <= 1'b1;
                end
            endcase
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: next_state = (resetn) ? B : A;
            B: next_state = C;
            C: next_state = (x_seq == 2'b10 && x == 1'b1) ? D : C;
            D: next_state = (y == 1'b1) ? F : E;
            E: next_state = (y == 1'b1) ? F : (y_timer == 2'b01) ? A : E;
            F: next_state = F;
            default: next_state = A;
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
