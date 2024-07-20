module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // Parameter Definitions for State Encoding
    parameter A = 1'b0, B = 1'b1;
    
    // State register definition
    reg state, next_state;
    
    // Combinational logic block to determine next state
    always @(*) begin
        case (state)
            A: next_state = (in) ? A : B;
            B: next_state = (in) ? B : A;
            default: next_state = B;
        endcase
    end
    
    // Sequential logic block to update state on clock edge or reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= B;
        end else begin
            state <= next_state;
        end
    end
    
    // Output assignment
    assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
