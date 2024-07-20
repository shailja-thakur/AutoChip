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
    
    state_t current_state, next_state;
    reg [1:0] counter;
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            f <= 0;
            g <= 0;
            counter <= 0;
        end else begin
            case (current_state)
                STATE_A: begin 
                    f <= 1; 
                    g <= 0; 
                    counter <= 0;
                end
                STATE_B: f <= 0;
                STATE_C: f <= 0;
                STATE_D: f <= 0;
                STATE_E: f <= 0;
                STATE_F: f <= 0;
                STATE_G: f <= 0;
            endcase
        end
    end
    
    always @(*) begin
        case (current_state)
            STATE_A: next_state = resetn ? STATE_B : STATE_A;
            STATE_B: next_state = x ? STATE_C : STATE_B;
            STATE_C: next_state = !x ? STATE_D : STATE_B;
            STATE_D: next_state = x ? STATE_E : STATE_B;
            STATE_E: next_state = STATE_F;
            STATE_F: begin
                next_state = g ? STATE_G : STATE_F;
            end
            STATE_G: begin
                // Stay in this state indefinitely or until reset
                next_state = STATE_G;
            end
            default: next_state = STATE_A;
        endcase
    end
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            counter <= 0;
            g <= 0;
        end else if (current_state == STATE_F) begin
            if (y == 1)
                g <= 1;
            else if (counter < 2)
                counter <= counter + 1;
            else
                g <= 0;
        end
    end

endmodule
