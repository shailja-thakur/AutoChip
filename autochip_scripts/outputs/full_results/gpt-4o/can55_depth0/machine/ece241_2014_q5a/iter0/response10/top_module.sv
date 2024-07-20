module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State parameters
    parameter A = 2'b00, B = 2'b01, C = 2'b10;
    
    // State register
    reg [1:0] state, next_state;
    
    // State transition logic (combinational)
    always @(*) begin
        case (state)
            A: next_state = x ? C : A;
            B: next_state = x ? B : C;
            C: next_state = x ? B : C;
            default: next_state = A; // Default state
        endcase
    end
    
    // State register update (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end
    
    // Output logic
    always @(*) begin
        z = (state == C);
    end

endmodule
