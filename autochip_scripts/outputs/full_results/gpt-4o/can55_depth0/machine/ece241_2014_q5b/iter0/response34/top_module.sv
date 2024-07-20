module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    // Sequential logic for state transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state and output
    always @(*) begin
        case (state)
            A: begin
                z = (x == 1'b1) ? 1'b1 : 1'b0;
                next_state = (x == 1'b1) ? B : A;
            end
            B: begin
                z = (x == 1'b0) ? 1'b1 : 1'b0;
                next_state = B;
            end
            default: begin
                z = 1'b0;
                next_state = A;
            end
        endcase
    end

endmodule
