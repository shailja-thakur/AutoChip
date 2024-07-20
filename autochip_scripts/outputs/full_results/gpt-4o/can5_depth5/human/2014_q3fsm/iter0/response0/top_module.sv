module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_B1 = 2'b10,
        STATE_B2 = 2'b11
    } state_t;

    // State and counter registers
    state_t state, next_state;
    reg [1:0] w_counter; // 2-bit counter to count the number of 1's in 3 cycles
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= STATE_A;
            w_counter <= 2'd0;
            z <= 1'b0;
        end 
        else begin
            state <= next_state;
            if (state == STATE_B2) begin
                if (w_counter == 2)
                    z <= 1'b1;
                else
                    z <= 1'b0;
                w_counter <= 2'd0; // reset counter after evaluation
            end
            else if (state == STATE_B || state == STATE_B1) begin
                w_counter <= w_counter + w;
            end
        end
    end

    always_comb begin
        next_state = state; // hold state by default
        case (state)
            STATE_A: begin
                if (s)
                    next_state = STATE_B;
            end
            
            STATE_B: begin
                next_state = STATE_B1;
            end
            
            STATE_B1: begin
                next_state = STATE_B2;
            end
            
            STATE_B2: begin
                next_state = STATE_B;
            end
            
            default: begin
                next_state = STATE_A;
            end
        endcase
    end

endmodule
