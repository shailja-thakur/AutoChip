module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum logic [2:0] {
        state_A = 3'b000,
        state_B = 3'b001,
        state_C = 3'b010,
        state_D = 3'b011,
        state_E = 3'b100,
        state_F = 3'b101,
        state_G = 3'b110
    } state_t;

    state_t state, next_state;
    reg [1:0] y_counter;

    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= state_A;
            y_counter <= 2'b00;
        end else begin
            state <= next_state;
            if (state == state_F)
                y_counter <= y_counter + 1;
        end
    end

    always_comb begin
        next_state = state;
        f = 0;
        g = 0;
        case (state)
            state_A: begin
                f = 0;
                g = 0;
                if (!resetn) begin
                    next_state = state_B;
                end
            end
            state_B: begin
                f = 1;
                next_state = state_C;
            end
            state_C: begin
                if (x) begin
                    next_state = state_D;
                end
            end
            state_D: begin
                if (!x) begin
                    next_state = state_E;
                end
            end
            state_E: begin
                if (x) begin
                    next_state = state_F;
                end
            end
            state_F: begin
                g = 1;
                if (y) begin
                    next_state = state_G;
                end else if (y_counter >= 2) begin
                    next_state = state_A;
                end
            end
            state_G: begin
                g = 1;
            end
            default: begin
                next_state = state_A;
            end
        endcase
    end
endmodule
