module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

    // State declaration
    typedef enum logic [1:0] {
        A = 2'd0,
        B = 2'd1,
        C = 2'd2,
        D = 2'd3
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = in ? B : A;
            B: next_state = in ? B : C;
            C: next_state = in ? D : A;
            D: next_state = in ? B : C;
            default: next_state = A; // Default case to catch an unexpected state
        endcase
    end
    
    // Output logic
    always @(*) begin
        case (state)
            D: out = 1;
            default: out = 0;
        endcase
    end
    
    // State register and asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

endmodule
