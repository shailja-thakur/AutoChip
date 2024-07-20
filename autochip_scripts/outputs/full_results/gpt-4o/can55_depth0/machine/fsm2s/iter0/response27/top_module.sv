module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

    // Define state encoding
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;
    
    state_t state, next_state;
    
    // Output logic
    always @(*) begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b0;
        endcase
    end
    
    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = j ? B : A;
            B: next_state = k ? A : B;
            default: next_state = A;
        endcase
    end
    
    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;  // Initialize to state A on reset
        end else begin
            state <= next_state;
        end
    end
    
endmodule
