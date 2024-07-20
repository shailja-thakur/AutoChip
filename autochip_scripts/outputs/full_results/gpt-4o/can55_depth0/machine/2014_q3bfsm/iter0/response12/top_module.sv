module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);
    reg [2:0] state, next_state;
    
    // State encoding
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    parameter E = 3'b100;
    
    // State Transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Next State Logic
    always @(*) begin
        case (state)
            A: next_state = x ? B : A;
            B: next_state = x ? E : B;
            C: next_state = x ? B : C;
            D: next_state = x ? C : B;
            E: next_state = x ? E : D;
            default: next_state = A;
        endcase
    end
    
    // Output Logic
    always @(*) begin
        case (state)
            D, E: z = 1;
            default: z = 0;
        endcase
    end
endmodule
