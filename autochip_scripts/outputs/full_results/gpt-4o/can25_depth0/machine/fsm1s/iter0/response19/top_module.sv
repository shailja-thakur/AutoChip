module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State declarations
    parameter A = 1'b0;
    parameter B = 1'b1;

    reg state, next_state;

    // Combinational logic block to determine next state
    always @(*) begin
        case (state)
            A: next_state = (in) ? A : B;
            B: next_state = (in) ? B : A;
        endcase
    end

    // Sequential logic block triggered on clock edge or reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B;
        else
            state <= next_state;
    end

    // Output logic
    assign out = (state == B);

endmodule
