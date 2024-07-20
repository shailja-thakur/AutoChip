module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // Define state encoding
    reg state, next_state;
    parameter A = 1'b0;
    parameter B = 1'b1;

    // State transition logic
    always @(*) begin
        case (state)
            A: begin
                if (x) begin
                    next_state = B;
                    z = 1'b1;
                end else begin
                    next_state = A;
                    z = 1'b0;
                end
            end
            B: begin
                if (x) begin
                    next_state = B;
                    z = 1'b0;
                end else begin
                    next_state = B;
                    z = 1'b1;
                end
            end
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end
endmodule
