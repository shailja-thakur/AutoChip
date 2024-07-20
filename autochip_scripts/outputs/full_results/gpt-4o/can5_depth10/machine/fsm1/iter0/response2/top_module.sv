module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    reg state, next_state;
    
    // State encoding
    parameter A = 1'b0, B = 1'b1;
    
    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = B;
        endcase
    end
    
    // State update on clock edge and asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= B;
        end else begin
            state <= next_state;
        end
    end
    
    // Output logic
    always @(*) begin
        out = (state == B);
    end
endmodule
