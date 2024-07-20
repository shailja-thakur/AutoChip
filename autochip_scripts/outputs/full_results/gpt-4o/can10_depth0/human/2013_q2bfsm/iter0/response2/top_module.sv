module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State encoding
    typedef enum reg [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101,
        G = 3'b110
    } state_t;

    state_t state, next_state;
    reg [1:0] x_seq, y_seq;

    // State transition logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= A;
            x_seq <= 2'b00;
            y_seq <= 2'b00;
            f <= 0;
            g <= 0;
        end else begin
            state <= next_state;
        end
    end

    // Next state and output logic
    always @(*) begin
        next_state = state;
        f = 0;
        case(state)
            A: begin
                if (resetn) next_state = B;
            end
            B: begin
                f = 1;
                next_state = C;
            end
            C: begin
                if (x == 1 && x_seq[1:0] == 2'b00) begin
                    x_seq = 2'b01;
                    next_state = D;
                end else if (x == 0 && x_seq[1:0] == 2'b01) begin
                    x_seq = 2'b10;
                    next_state = E;
                end else if (x == 1 && x_seq[1:0] == 2'b10) begin
                    next_state = F;
                end
            end
            D: begin
                if (x == 0) begin
                    next_state = E;
                end else begin
                    next_state = C;
                end
            end
            E: begin
                if (x == 1) begin
                    next_state = F;
                end else begin
                    next_state = C;
                end
            end
            F: begin
                g = 1;
                next_state = G;
            end
            G: begin
                if (y == 1) begin
                    next_state = G;
                end else if (y_seq == 2'b10) begin
                    g = 0;
                end else begin
                    y_seq = y_seq + 1;
                end
            end
            default: next_state = A;
        endcase
    end

endmodule
