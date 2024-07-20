module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State Definitions
    typedef enum reg [1:0] {
        A = 2'b00, // Reset State
        B = 2'b01, // Checking w state 1
        C = 2'b10, // Checking w state 2
        D = 2'b11  // Checking w state 3
    } state_t;
    
    state_t state, next_state;
    reg [1:0] w_count; // Count of how many times w = 1 in three clock cycles
    
    // State Transition on Clock Edge
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            z <= 0;
            w_count <= 0;
        end else begin
            state <= next_state;
        end
    end
    
    // Next State Logic
    always @(*) begin
        next_state = state;
        case(state)
            A: begin
                if (s) next_state = B;
            end
            B: begin
                if (w_count < 3) next_state = C;
                w_count = w_count + w;
            end
            C: begin
                if (w_count < 3) next_state = D;
                w_count = w_count + w;
            end
            D: begin
                if (w_count == 2) z = 1;
                else z = 0;
                next_state = B;
                w_count = w; // to start counting for the next 3 cycles
            end
        endcase
    end

endmodule
