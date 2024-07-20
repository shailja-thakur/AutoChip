module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State encoding
    typedef enum reg[2:0] {
        STATE_A = 3'd0,
        STATE_B = 3'd1,
        STATE_C = 3'd2,
        STATE_D = 3'd3,
        STATE_E = 3'd4,
        STATE_F = 3'd5
    } state_t;

    state_t state, next_state;
    reg [1:0] y_counter;

    // State transition and output logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= STATE_A;
            f <= 0;
            g <= 0;
            y_counter <= 2'b00;
        end else begin
            state <= next_state;

            case (state)
                STATE_A: begin
                    f <= 1;
                    g <= 0;
                end
                
                STATE_B: begin
                    f <= 0;
                end
                
                STATE_C: begin
                end
                
                STATE_D: begin
                end
                
                STATE_E: begin
                end
                
                STATE_F: begin
                end
            endcase
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        case (state)
            STATE_A: begin
                if (!resetn) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
            end
            
            STATE_B: begin
                if (x) begin
                    next_state = STATE_C;
                end else begin
                    next_state = STATE_B;
                end
            end
            
            STATE_C: begin
                if (!x) begin
                    next_state = STATE_D;
                end else begin
                    next_state = STATE_C;
                end
            end
            
            STATE_D: begin
                if (x) begin
                    next_state = STATE_E;
                end else begin
                    next_state = STATE_B;
                end
            end
            
            STATE_E: begin
                g <= 1;
                y_counter <= 2'b00;
                next_state = STATE_F;
            end
            
            STATE_F: begin
                if (y) begin
                    g <= 1;
                end else if (y_counter == 2'b01) begin
                    y_counter <= y_counter + 1'b1;
                end else begin
                    g <= 0;
                end
            end
        endcase
    end
endmodule
