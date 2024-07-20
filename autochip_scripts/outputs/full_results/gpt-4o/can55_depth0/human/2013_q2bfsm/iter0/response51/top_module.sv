module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);
    
    reg [2:0] state, next_state;
    reg [1:0] y_count;
    
    // State encoding
    localparam STATE_A = 3'b000;
    localparam STATE_B = 3'b001;
    localparam STATE_C = 3'b010;
    localparam STATE_D = 3'b011;
    localparam STATE_E = 3'b100;
    localparam STATE_F = 3'b101;
    
    // State transition logic (sequential)
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= STATE_A;
            y_count <= 2'b00;
        end else begin
            state <= next_state;
            if (state == STATE_E || state == STATE_D)
                y_count <= y_count + 1;
            else
                y_count <= 2'b00;
        end
    end
    
    // Output logic (combinational)
    always @(*) begin
        case (state)
            STATE_A: begin
                f = 0;
                g = 0;
                next_state = resetn ? STATE_B : STATE_A;
            end
            STATE_B: begin
                f = 1;
                g = 0;
                next_state = STATE_C;
            end
            STATE_C: begin
                f = 0;
                g = 0;
                if (x == 1)
                    next_state = STATE_D;
                else
                    next_state = STATE_C;
            end
            STATE_D: begin
                f = 0;
                g = 0;
                if (x == 0)
                    next_state = STATE_E;
                else
                    next_state = STATE_D;
            end
            STATE_E: begin
                f = 0;
                g = 0;
                if (x == 1)
                    next_state = STATE_F;
                else
                    next_state = STATE_E;
            end
            STATE_F: begin
                f = 0;
                g = 1;
                if (y == 1)
                    next_state = STATE_F;
                else if (y_count == 2'b10)
                    next_state = STATE_C;
                else
                    next_state = STATE_F;
            end
            default: begin
                f = 0;
                g = 0;
                next_state = STATE_A;
            end
        endcase
    end
    
endmodule
