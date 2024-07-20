module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    // State encoding
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    
    reg [1:0] state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end
    
    always @(*) begin
        case (state)
            A: next_state = x ? C : A;
            B: next_state = x ? B : C;
            C: next_state = x ? B : C;
            default: next_state = A; // default state
        endcase
    end

    // Output logic
    assign z = (state == C);

endmodule
