module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // Define state parameters
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    // Combinational block to determine next state
    always @ (*) begin
        case (state)
            A: if (j) next_state = B; else next_state = A;
            B: if (k) next_state = A; else next_state = B;
            default: next_state = A;
        endcase
    end

    // Sequential block to update state on clock edge
    always @ (posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @ (posedge clk or posedge areset) begin
        if (areset)
            out <= 1'b0;
        else
            out <= (state == B);
    end

endmodule
