module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;
    
    reg [1:0] current_state, next_state;

    // State Transition Logic
    always @(posedge clk or posedge reset) begin
        if (reset) 
            current_state <= A;  // Reset state to A
        else 
            current_state <= next_state;  // Transition to next state
    end

    // Next State Logic
    always @(*) begin
        case (current_state)
            A: next_state = in ? B : A;
            B: next_state = in ? B : C;
            C: next_state = in ? D : A;
            D: next_state = in ? B : C;
            default: next_state = A;
        endcase
    end

    // Output Logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            out <= 0;
        else
            out <= (current_state == D);
    end
endmodule
