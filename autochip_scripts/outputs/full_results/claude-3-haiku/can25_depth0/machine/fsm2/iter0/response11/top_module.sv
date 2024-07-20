module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    reg state, next_state;
    
    // State definitions
    parameter A = 1'b0;
    parameter B = 1'b1;
    
    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            A: begin
                if (j) next_state = B;
                else next_state = A;
            end
            B: begin
                if (k) next_state = A;
                else next_state = B;
            end
            default: next_state = A;
        endcase
    end
    
    // Sequential logic to update state
    always @(posedge clk or negedge areset) begin
        if (!areset) begin
            state <= A;
        end
        else begin
            state <= next_state;
        end
    end
    
    // Output logic
    always @(*) begin
        out = (state == B);
    end

endmodule
