module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    // Define the states using parameters
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    parameter E = 3'b100;
    
    reg [2:0] state, next_state;
    
    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic
    always @(*) begin
        case(state)
            A: next_state = (x) ? B : A;
            B: next_state = (x) ? E : B;
            C: next_state = (x) ? B : C;
            D: next_state = (x) ? C : B;
            E: next_state = (x) ? E : D;
            default: next_state = A; // default to state A in case of undefined state
        endcase
    end
    
    // Output logic
    always @(*) begin
        case(state)
            D: z = 1'b1;
            E: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
