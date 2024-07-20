module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    // Define states using parameters for readability
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    parameter E = 3'b100;
    parameter F = 3'b101;
    
    reg [2:0] state, next_state; // State register and next state logic

    // Synchronous state transition
    always @(posedge clk) begin
        if (reset) 
            state <= A; // Reset to state A
        else
            state <= next_state;
    end

    // Combinational logic for next state
    always @(*) begin
        case (state)
            A:       next_state = (w) ? B : A;
            B:       next_state = (w) ? C : D;
            C:       next_state = (w) ? E : D;
            D:       next_state = (w) ? F : A;
            E:       next_state = (w) ? E : D;
            F:       next_state = (w) ? C : D;
            default: next_state = A;  // Default state
        endcase
    end

    // Output logic
    assign z = (state == E || state == F);

endmodule
