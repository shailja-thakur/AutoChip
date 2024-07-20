module top_module (
    input clk,
    input reset,
    input w,
    output z
);
    reg [2:0] state, next_state;
    
    // State encoding
    localparam A = 3'b000,
               B = 3'b001,
               C = 3'b010,
               D = 3'b011,
               E = 3'b100,
               F = 3'b101;
               
    // Synchronous state transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            A: next_state = (w) ? B : A;
            B: next_state = (w) ? C : D;
            C: next_state = (w) ? E : D;
            D: next_state = (w) ? F : A;
            E: next_state = (w) ? E : D;
            F: next_state = (w) ? C : D;
            default: next_state = A;
        endcase
    end
    
    // Output logic
    assign z = (state == E || state == F) ? 1'b1 : 1'b0;

endmodule
