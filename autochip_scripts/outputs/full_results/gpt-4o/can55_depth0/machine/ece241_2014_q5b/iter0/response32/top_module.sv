module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;
    
    // State transition logic (combinational logic)
    always @(*) begin
        case (state)
            A: begin
                if (x) 
                    next_state = B;
                else 
                    next_state = A;
            end
            B: begin
                next_state = B;
            end
            default: begin
                next_state = A;
            end
        endcase
    end

    // State update logic (sequential logic)
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        if ((state == A && x == 1'b1) || (state == B && x == 1'b0))
            z = 1'b1;
        else
            z = 1'b0;
    end

endmodule
