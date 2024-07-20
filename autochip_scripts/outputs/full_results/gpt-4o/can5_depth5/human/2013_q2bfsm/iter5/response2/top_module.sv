module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State definitions
    typedef enum reg [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;

    state_t state, next_state;
    reg [1:0] y_timer;
    reg [2:0] x_shift;

    // State transition and output logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= A;
            f <= 0;
            g <= 0;
            y_timer <= 2'b00;
            x_shift <= 3'b000;
        end else begin
            state <= next_state;
            case (next_state)
                B: f <= 1;     // Set 'f' to 1 for one clock cycle in state B
                default: f <= 0;
            endcase
            if (state == E || state == D)
                g <= 1;
            else
                g <= (state == F) ? g : 0;
            
            if (state == D)
                y_timer <= 2'b00;
            else if (state == E)
                y_timer <= y_timer + 1;
            else
                y_timer <= 2'b00;
            
            if (state == C)
                x_shift <= {x_shift[1:0], x};
            else
                x_shift <= 3'b000;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: next_state = resetn ? B : A;
            B: next_state = C;
            C: next_state = (x_shift == 3'b101) ? D : C;
            D: next_state = (y == 1'b1) ? F : E;
            E: next_state = (y == 1'b1) ? F : (y_timer == 2'b01) ? A : E;
            F: next_state = F;
            default: next_state = A;
        endcase
    end

endmodule
