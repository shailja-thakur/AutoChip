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
        STATE_G = 3'b110,
        STATE_H = 3'b111
    } state_t;

    state_t state, state_next;

    // State transition logic
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) 
        begin
            state <= STATE_A;
        end 
        else 
        begin
            state <= state_next;
        end
    end

    // Output logic and next state logic
    always_comb begin
        state_next = state; // default state is the current state
        f = 1'b0;
        g = 1'b0;
        
        unique case (state)
            STATE_A: begin
                f = 1'b0;
                g = 1'b0;
                if (resetn) 
                begin
                    state_next = STATE_B;
                end
            end
            
            STATE_B: begin
                f = 1'b1;
                state_next = STATE_C; 
            end
            
            STATE_C: begin
                f = 1'b0;
                if (x == 1'b1) state_next = STATE_D;
            end
            
            STATE_D: begin
                if (x == 1'b0) 
                begin
                    state_next = STATE_E;
                end
            end
            
            STATE_E: begin
                if (x == 1'b1) 
                begin
                    state_next = STATE_F;
                end
            end
            
            STATE_F: begin
                g = 1'b1;
                state_next = STATE_G;
            end
            
            STATE_G: begin
                g = 1'b1;
                if (y == 1'b1) 
                begin
                    state_next = STATE_H;
                end 
                else 
                begin
                    state_next = STATE_H;
                end
            end
            
            STATE_H: begin
                g = 1'b1;
            end
            
            default: begin
                state_next = STATE_A;
            end
        endcase
    end
endmodule
