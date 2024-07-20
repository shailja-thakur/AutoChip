module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State Encoding
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;
    
    state_t current_state, next_state;
    
    // State Transition Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end
    
    // Next State Logic
    always @(*) begin
        case (current_state)
            A: begin
                if (in)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (in)
                    next_state = B;
                else
                    next_state = C;
            end
            C: begin
                if (in)
                    next_state = D;
                else
                    next_state = A;
            end
            D: begin
                if (in)
                    next_state = B;
                else
                    next_state = C;
            end
            default: next_state = A;  // Default state
        endcase
    end
    
    // Output Logic
    always @(posedge clk) begin
        if (current_state == D) begin
            out <= 1;
        end else begin
            out <= 0;
        end
    end

endmodule
