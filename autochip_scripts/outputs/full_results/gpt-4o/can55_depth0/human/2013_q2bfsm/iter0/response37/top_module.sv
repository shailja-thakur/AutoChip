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
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101,
        STATE_G = 3'b110
    } state_t;

    state_t state, next_state;
    reg [2:0] x_shift;

    // Sequential logic to update state
    always @(posedge clk) begin
        if (!resetn) begin
            state <= STATE_A;
            x_shift <= 3'b0;
        end 
        else begin
            state <= next_state;
            x_shift <= {x_shift[1:0], x}; // Shift register for x input
        end
    end

    // Combinational logic to determine next state
    always @(*) begin
        next_state = state;
        f = 0;
        g = g;

        case (state)
            STATE_A: begin
                if (!resetn) begin
                    next_state = STATE_A;
                end 
                else begin
                    next_state = STATE_B;
                    f = 1;
                end
            end

            STATE_B: begin
                next_state = STATE_C;
            end

            STATE_C: begin
                if (x_shift == 3'b101) begin
                    next_state = STATE_D;
                end
            end

            STATE_D: begin
                next_state = STATE_E;
                g = 1;
            end

            STATE_E: begin
                if (y) begin
                    next_state = STATE_F;
                end 
                else begin
                    next_state = STATE_G;
                end
            end

            STATE_F: begin
                g = 1;
            end

            STATE_G: begin
                g = 0;
            end

            default: begin
                next_state = STATE_A;
            end
        endcase
    end

endmodule
