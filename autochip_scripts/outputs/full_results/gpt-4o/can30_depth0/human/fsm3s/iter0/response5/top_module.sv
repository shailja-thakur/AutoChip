module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    // Define states using local parameters
    localparam A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
    
    // State and next state registers
    reg [1:0] state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = in ? B : A;
            B: next_state = in ? B : C;
            C: next_state = in ? D : A;
            D: next_state = in ? B : C;
            default: next_state = A;
        endcase
    end
    
    // State update logic (synchronous reset)
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b0;
            C: out = 1'b0;
            D: out = 1'b1;
            default: out = 1'b0;
        endcase
    end
endmodule
