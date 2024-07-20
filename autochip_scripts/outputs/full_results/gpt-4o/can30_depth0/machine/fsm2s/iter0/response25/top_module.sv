module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // Define state encoding
    typedef enum reg [0:0] { 
        A = 1'b0, 
        B = 1'b1 
    } state_t;
    
    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            A: next_state = (j == 1'b1) ? B : A;
            B: next_state = (k == 1'b1) ? A : B;
            default: next_state = A; // default state (should not occur)
        endcase
    end
    
    // State register with reset logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end
    
    // Output logic based on current state
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out <= 1'b0;
        end else begin
            out <= (current_state == B);
        end
    end

endmodule
