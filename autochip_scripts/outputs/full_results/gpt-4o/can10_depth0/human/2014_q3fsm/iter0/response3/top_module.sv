module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    typedef enum reg [1:0] {A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11} state_t;
    state_t state, next_state;
    
    reg [1:0] w_count;  // To count the number of 1s in three clock cycles
    
    // State transitions
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b00;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        z = 1'b0;
        case(state)
            A: 
                if (s) 
                    next_state = B;
                else 
                    next_state = A;
            
            B: begin
                if (w_count == 2'd2)
                    z = 1'b1; // Set z to 1 in the following clock cycle if w is 1 exactly twice

                w_count = w_count + w; // Count the number of 1s in three clock cycles
                
                if (w_count >= 3) 
                    w_count = 2'd0;  // Reset count after three cycles

                next_state = B; // Stay in state B
            end
        endcase
    end
endmodule
