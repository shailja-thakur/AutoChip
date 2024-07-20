module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    // State variables
    state_t state, next_state;
    
    // Output logic
    always @(*) begin
        case (state)
            STATE_A: begin
                g = 3'b000;
                if (r[1])
                    next_state = STATE_B;
                else if (r[2])
                    next_state = STATE_C;
                else if (r[3])
                    next_state = STATE_D;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                g = 3'b001;
                if (r[1])
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_C: begin
                g = 3'b010;
                if (r[2])
                    next_state = STATE_C;
                else
                    next_state = STATE_A;
            end
            STATE_D: begin
                g = 3'b100;
                next_state = STATE_A; // D transits to A immediately since it has no persist condition
            end
            default: begin
                g = 3'b000;
                next_state = STATE_A;
            end
        endcase
    end
    
    // State flip-flops
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

endmodule
