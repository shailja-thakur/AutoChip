module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State declarations
    typedef enum reg [1:0] {
        S_A = 2'b00,  // Reset state
        S_B = 2'b01   // State after s goes high
    } state_t;
    
    state_t state, next_state;
    
    reg [1:0] count;      // Counter to track number of 1's in w during the three cycle observation
    reg [1:0] cycle_cnt;  // Cycle counter for three clock cycles
    
    // Output logic
    always @(*) begin
        if (state == S_B && cycle_cnt == 3 && count == 2)
            z = 1;
        else
            z = 0;
    end

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S_A;
            count <= 0;
            cycle_cnt <= 0;
        end else begin
            state <= next_state;
            
            if (state == S_B) begin
                cycle_cnt <= cycle_cnt + 1;
                
                if (w == 1)
                    count <= count + 1;
                
                if (cycle_cnt == 3) begin
                    cycle_cnt <= 0;
                    count <= 0;  // Reset counter after three cycles
                end
            end else begin
                cycle_cnt <= 0;
                count <= 0;
            end
        end
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            S_A: begin
                if (s == 1)
                    next_state = S_B;
                else
                    next_state = S_A;
            end
            S_B: begin
                next_state = S_B;  // Remain in state B
            end
            default: next_state = S_A;
        endcase
    end
endmodule
