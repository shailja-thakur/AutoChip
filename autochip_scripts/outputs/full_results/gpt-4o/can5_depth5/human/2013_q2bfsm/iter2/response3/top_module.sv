module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    reg [2:0] state, next_state;
    reg [1:0] x_counter, y_counter;

    // State encoding
    localparam [2:0] A = 3'b000,
                     B = 3'b001,
                     C = 3'b010,
                     D = 3'b011,
                     E = 3'b100;

    // State transition
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= A;
            x_counter <= 2'b00;
            y_counter <= 2'b00;
            f <= 1'b0;
            g <= 1'b0;
        end
        else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                f = 1'b0;
                g = 1'b0;
                next_state = (resetn) ? B : A;
            end

            B: begin
                f = 1'b1;
                g = 1'b0;
                next_state = C;
            end

            C: begin
                f = 1'b0;
                g = 1'b0;
                if (x_counter == 2'b11) begin
                    next_state = D;
                end
                else begin
                    next_state = C;
                end
            end

            D: begin
                f = 1'b0;
                g = 1'b1;
                if (y_counter == 2'b01) begin
                    next_state = E;
                end
                else if (y_counter == 2'b10) begin
                    next_state = E;
                end
                else begin
                    next_state = D;
                end
            end

            E: begin
                f = 1'b0;
                next_state = E;
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
            x_counter <= 2'b00;
        end
        else if (state == C) begin
            if (x_counter == 2'b00 && x == 1'b1)
                x_counter <= 2'b01;
            else if (x_counter == 2'b01 && x == 1'b0)
                x_counter <= 2'b10;
            else if (x_counter == 2'b10 && x == 1'b1)
                x_counter <= 2'b11;
            else if (x_counter != 2'b11)
                x_counter <= 2'b00;
        end
        else begin
            x_counter <= 2'b00;
        end
    end

    // Monitoring y input with a timer for max 2 cycles
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            y_counter <= 2'b00;
        end
        else if (state == D) begin
            if (y == 1'b1)
                y_counter <= 2'b01;
            else if (y_counter == 2'b00)
                y_counter <= 2'b10;
            else
                y_counter <= y_counter;
        end
        else begin
            y_counter <= 2'b00;
        end
    end

    // Output logic for g in state machine
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            g <= 1'b0;
        else if (state == D && !(y_counter == 2'b10 && y != 1'b1))
            g <= 1'b1;
        else if (state == D && (y_counter == 2'b10 && y != 1'b1))
            g <= 1'b0;
    end

endmodule
