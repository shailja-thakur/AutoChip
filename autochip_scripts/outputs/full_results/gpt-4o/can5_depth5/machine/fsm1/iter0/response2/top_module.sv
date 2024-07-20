module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);
    // Define the states
    typedef enum logic {A, B} state_t;
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case(state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = B;
        endcase
    end
    
    // State register logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= B;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        case(state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b0;
        endcase
    end
endmodule
