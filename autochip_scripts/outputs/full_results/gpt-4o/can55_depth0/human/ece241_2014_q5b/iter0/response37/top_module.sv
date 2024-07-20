module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    // state declaration
    reg [1:0] state, next_state;
    localparam A = 2'b01, B = 2'b10; // One-hot encoding for states A and B

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            A: if (x) next_state = B;
               else   next_state = A;
            B: next_state = B;
            default: next_state = A;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A; // reset to initial state A
        else
            state <= next_state;
    end

    // Output logic (combinational)
    assign z = (state == A) ? x : ~x;

endmodule
