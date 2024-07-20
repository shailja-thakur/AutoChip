module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    typedef enum reg [2:0] {
        A    = 3'b000,
        B    = 3'b001,
        C    = 3'b010,
        S10  = 3'b011,
        S11  = 3'b100,
        S20  = 3'b101,
        S21  = 3'b110,
        S22  = 3'b111
    } state_t;

    state_t current_state, next_state;
    
    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        case (current_state)
            A: begin
                if (s) 
                    next_state = B;
                else 
                    next_state = A;
            end
            
            B: begin
                if (w) 
                    next_state = S11;
                else 
                    next_state = S10;
            end
            
            C: begin
                if (w) 
                    next_state = S11;
                else 
                    next_state = S10;
            end
            
            S10: begin
                if (w) 
                    next_state = S21;
                else 
                    next_state = S20;
            end
            
            S11: begin
                if (w) 
                    next_state = S22;
                else 
                    next_state = S21;
            end
            
            S20: next_state = B;
            
            S21: begin
                if (w) 
                    next_state = C;
                else 
                    next_state = B;
            end
            
            S22: begin
                if (w) 
                    next_state = B;
                else 
                    next_state = C;
            end
            
            default: next_state = A;
        endcase
    end

    // Output Logic
    always @(current_state) begin
        // Define the output z based on the requirements
        // Since the requirements for 'z' is not specified, let's consider 'z' to be asserted in state S11
        // You can modify this assignment based on actual requirements where output needs to be asserted.
        case (current_state)
            S11: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
