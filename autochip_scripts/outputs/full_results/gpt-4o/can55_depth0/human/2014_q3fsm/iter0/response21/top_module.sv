module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B1 = 2'b01,
        STATE_B2 = 2'b10,
        STATE_B3 = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [1:0] w_count; // counter for w being 1
    
    // Sequential logic for state transition
    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_A;
            z <= 0;
            w_count <= 0;
        end else begin
            state <= next_state;
            if (state == STATE_B3) begin
                z <= (w_count == 2) ? 1 : 0;
            end else begin
                z <= 0;
            end
            if (state == STATE_B1 || state == STATE_B2 || state == STATE_B3) begin
                if (w) begin
                    w_count <= w_count + 1;
                end
            end else begin
                w_count <= 0;
            end
        end
    end
    
    // Combinational logic for next state
    always @(*) begin
        next_state = state;
        case(state)
            STATE_A: begin
                if (s) begin
                    next_state = STATE_B1;
                end
            end

            STATE_B1: begin
                next_state = STATE_B2;
            end

            STATE_B2: begin
                next_state = STATE_B3;
            end

            STATE_B3: begin
                next_state = STATE_B1; // Go back to checking w for next 3 cycles
            end

        endcase
    end
endmodule
