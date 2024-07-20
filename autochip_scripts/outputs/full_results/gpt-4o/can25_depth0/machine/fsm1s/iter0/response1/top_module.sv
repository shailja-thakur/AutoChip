module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define state parameters
    parameter A = 1'b0;
    parameter B = 1'b1;
    
    // State register
    reg state, next_state;
    
    // Combinational logic to determine the next state
    always @(*) begin
        case (state)
            A: next_state = (in) ? A : B;
            B: next_state = (in) ? B : A;
            default: next_state = A;
        endcase
    end
    
    // Sequential logic to update the state on the rising edge of the clk
    // or reset the state to B when reset is high
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= B;
        end else begin
            state <= next_state;
        end
    end
    
    // Output logic
    always @(state) begin
        out = (state == B) ? 1'b1 : 1'b0;
    end

endmodule
