module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum reg [2:0] {
        STATE_A,
        STATE_B,
        STATE_C,
        STATE_D,
        STATE_E,
        STATE_F
    } state_t;
    
    reg [2:0] current_state, next_state;
    reg [1:0] x_count, y_count;

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            current_state <= STATE_A;
            f <= 0;
            g <= 0;
            x_count <= 0;
            y_count <= 0;
        end else begin
            current_state <= next_state;
        end
    end
    
    always @(*) begin
        next_state = current_state;
        case (current_state)
            STATE_A: begin
                f = 0;
                g = 0;
                if (~resetn) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
            end
            
            STATE_B: begin
                f = 1;
                next_state = STATE_C;
            end
            
            STATE_C: begin
                f = 0;
                if (x_count == 2'b10) begin
                    next_state = STATE_D;
                end else begin
                    next_state = STATE_C;
                end
            end
            
            STATE_D: begin
                if (x_count == 2'b10) begin
                    next_state = STATE_E;
                end else begin
                    next_state = STATE_D;
                end
            end
            
            STATE_E: begin
                g = 1;
                if (y == 1) begin
                    next_state = STATE_F;
                end else if (y_count == 2'b10) begin
                    g = 0;
                    next_state = STATE_A;
                end
            end
            
            STATE_F: begin
                g = 1;
            end
            
            default: begin
                next_state = STATE_A;
            end
        endcase
    end
    
    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            x_count <= 0;
        end else if (next_state == STATE_C) begin
            x_count <= 0;
        end else if (current_state == STATE_D) begin
            x_count <= x_count + 1;
        end
    end
    
    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            y_count <= 0;
        end else if (current_state == STATE_E) begin
            y_count <= y_count + 1;
        end else if (current_state == STATE_F) begin
            y_count <= 0;
        end
    end
    
endmodule
