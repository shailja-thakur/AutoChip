module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
    
    // State encoding
    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;
    
    state_t state, next_state;
    
    // State flip-flops
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end
    
    // State transition table
    always_comb begin
        case (state)
            A: begin
                if (w) next_state = B;
                else next_state = A;
                z = 1'b0;
            end
            
            B: begin
                if (w) next_state = C;
                else next_state = D;
                z = 1'b0;
            end
            
            C: begin
                if (w) next_state = E;
                else next_state = D;
                z = 1'b0;
            end
            
            D: begin
                if (w) next_state = F;
                else next_state = A;
                z = 1'b0;
            end
            
            E: begin
                if (w) next_state = E;
                else next_state = D;
                z = 1'b1;
            end
            
            F: begin
                if (w) next_state = C;
                else next_state = D;
                z = 1'b1;
            end
            
            default: begin
                next_state = A;
                z = 1'b0;
            end
        endcase
    end
    
endmodule
