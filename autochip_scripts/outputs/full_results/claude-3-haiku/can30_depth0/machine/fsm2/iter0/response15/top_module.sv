module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    reg current_state, next_state;
    parameter A = 1'b0, B = 1'b1;

    // Combinational logic to determine the next state
    always @(*) begin
        case (current_state)
            A: begin
                if (j)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (k)
                    next_state = A;
                else
                    next_state = B;
            end
            default: next_state = A;
        endcase
    end

    // Sequential logic to update the current state
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        if (current_state == B)
            out = 1'b1;
        else
            out = 1'b0;
    end

endmodule
