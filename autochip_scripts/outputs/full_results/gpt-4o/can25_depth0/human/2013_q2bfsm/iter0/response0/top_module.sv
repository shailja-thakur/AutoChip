module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State encoding
    typedef enum logic [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101,
        STATE_G = 3'b110
    } state_t;
    
    state_t current_state, next_state;
    reg [1:0] count; // Counter to monitor 'y' for 2 cycles

    // State transition
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        next_state = current_state;
        case (current_state)
            STATE_A: begin
                if (!resetn)
                    next_state = STATE_B;
            end
            STATE_B: next_state = STATE_C;
            STATE_C: next_state = x ? STATE_D : STATE_C;
            STATE_D: next_state = x ? STATE_E : STATE_C;
            STATE_E: next_state = x ? STATE_F : STATE_C;
            STATE_F: begin
                if (y)
                    next_state = STATE_G;
                else if (count == 2)
                    next_state = STATE_A;
            end
            STATE_G: next_state = STATE_G;
        endcase
    end

    // Output logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            f <= 0;
            g <= 0;
            count <= 0;
        end else begin
            f <= (current_state == STATE_B);
            if (current_state == STATE_F) begin
                if (y)
                    g <= 1;
                else if (count < 2)
                    count <= count + 1;
                else
                    g <= 0;
            end else begin
                count <= 0;
            end
        end
    end

endmodule
