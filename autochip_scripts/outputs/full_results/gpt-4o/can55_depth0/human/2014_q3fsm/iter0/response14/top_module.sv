module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    typedef enum reg [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101
    } state_t;
    
    state_t state, next_state;
    reg [1:0] w_count;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= STATE_A;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state; // default next state is the current state
        z = 0; // default output
        
        case (state)
            STATE_A: begin
                if (s)
                    next_state = STATE_B;
            end

            STATE_B: begin
                next_state = STATE_C;
                w_count = 0;
            end
            
            STATE_C: begin
                w_count = w_count + w;
                next_state = STATE_D;
            end
            
            STATE_D: begin
                w_count = w_count + w;
                next_state = STATE_E;
            end
            
            STATE_E: begin
                w_count = w_count + w;
                if (w_count == 2)
                    z = 1;
                next_state = STATE_F;
            end
            
            STATE_F: begin
                next_state = STATE_B;
            end
            
            default: next_state = STATE_A;
        endcase
    end

endmodule
