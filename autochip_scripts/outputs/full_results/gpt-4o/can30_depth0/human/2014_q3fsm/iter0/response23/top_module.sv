module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    typedef enum reg [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100
    } state_t;
    
    state_t state, next_state;
    reg [1:0] w_count;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
            w_count <= 0;
            z <= 0;
        end else begin
            state <= next_state;
            if (state == A) begin
                z <= 0;
            end else if (state == E) begin
                if (w_count == 2) begin
                    z <= 1;
                end else begin
                    z <= 0;
                end
                w_count <= 0; // Reset counter for the next sequence
            end
            
            if (state == B || state == C || state == D) begin
                w_count <= w_count + w; // Increment count if w is 1
            end
        end
    end

    always @(*) begin
        case (state)
            A: begin
                if (s) next_state = B;
                else next_state = A;
            end
            B: next_state = C;
            C: next_state = D;
            D: next_state = E;
            E: next_state = B; // After checking the three cycles, go back to B
            default: next_state = A;
        endcase
    end
endmodule
