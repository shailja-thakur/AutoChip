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
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [1:0] w_count;
    reg [1:0] cycle_count;
    
    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= STATE_A;
            w_count <= 2'b00;
            cycle_count <= 2'b00;
            z <= 1'b0;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic and output logic
    always_comb begin
        next_state = state;
        z = 1'b0;  // Default value
        
        case (state)
            STATE_A: begin
                if (s) begin
                    next_state = STATE_B;
                end
            end
            
            STATE_B: begin
                if (cycle_count == 2'b11) begin
                    if (w_count == 2'b10) begin
                        z = 1'b1;
                    end
                    next_state = STATE_C;
                end
            end
            
            STATE_C: begin
                next_state = STATE_D;
            end
            
            STATE_D: begin
                cycle_count = 2'b00;
                w_count = 2'b00;
                if (s == 0) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
            end
        endcase
    end
    
    // Count cycles and w occurrences
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            cycle_count <= 2'b00;
            w_count <= 2'b00;
        end else if (state == STATE_B) begin
            cycle_count <= cycle_count + 1'b1;
            if (w) begin
                w_count <= w_count + 1'b1;
            end
        end
    end
endmodule
