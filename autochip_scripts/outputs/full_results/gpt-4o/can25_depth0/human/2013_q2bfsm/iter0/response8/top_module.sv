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

    state_t current_state, next_state;

    reg [1:0] x_sequence;
    reg [1:0] y_count;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= A;
            f <= 1'b0;
            g <= 1'b0;
            x_sequence <= 2'b00;
            y_count <= 2'b00;
        end 
        else begin
            current_state <= next_state;
            if (current_state == B)
                f <= 1'b1;
            else
                f <= 1'b0;

            if (current_state == E && y == 1)
                g <= 1'b1;
            else if (current_state == F)
                g <= 1'b0;
            else
                g <= g;
        end
    end

    always @(*) begin
        next_state = current_state;
        case (current_state)
            A: begin
                if (!resetn)
                    next_state = B;
            end

            B: begin
                if (resetn)
                    next_state = C;
            end

            C: begin
                x_sequence = {x_sequence[0], x};
                if (x_sequence == 2'b10) begin
                    if (x == 1)
                        next_state = D;
                end 
            end

            D: begin
                if (x == 0)
                    next_state = E;
                else
                    next_state = C;
            end

            E: begin
                if (y == 1)
                    next_state = F;
                else begin
                    if (y_count == 2'b01)
                        next_state = F;
                    else
                        y_count = y_count + 1;
                end
            end

            F: begin
                next_state = F;
            end
        endcase
    end
endmodule
