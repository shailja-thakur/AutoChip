module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    reg state, next_state;

    // State encoding
    localparam A = 1'b0;
    localparam B = 1'b1;

    // Combinational logic for next state
    always @(*) begin
        case (state)
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
        endcase
    end

    // Sequential logic for state transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    assign out = (state == B);

endmodule
