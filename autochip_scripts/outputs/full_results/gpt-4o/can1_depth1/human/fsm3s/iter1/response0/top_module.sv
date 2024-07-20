module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define state encoding
    localparam A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
    reg [1:0] state, next_state;

    // State transition
    always @(*) begin
        case (state)
            A: next_state = (in == 1'b0) ? A : B;
            B: next_state = (in == 1'b0) ? C : B;
            C: next_state = (in == 1'b0) ? A : D;
            D: next_state = (in == 1'b0) ? C : B;
            default: next_state = A;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset) 
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            D: out = 1;
            default: out = 0;
        endcase
    end

endmodule
