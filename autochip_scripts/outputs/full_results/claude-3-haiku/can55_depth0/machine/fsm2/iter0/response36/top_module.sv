module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // States
    localparam A = 1'b0;
    localparam B = 1'b1;

    // Internal registers
    reg state, next_state;

    // Combinational logic for next state
    always @(*) begin
        case (state)
            A: next_state = (j) ? B : A;
            B: next_state = (k) ? A : B;
            default: next_state = A;
        endcase
    end

    // Synchronous update of state
    always @(posedge clk or negedge areset) begin
        if (~areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        out = (state == B);
    end

endmodule
