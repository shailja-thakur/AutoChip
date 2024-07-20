module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // State declaration using one-hot encoding
    reg [1:0] state, next_state;
    parameter A = 2'b01, B = 2'b10;

    // State transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A; // Asynchronous reset to state A
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: if (x) next_state = B;
                else next_state = A;
            B: next_state = B;
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            A: if (x) z = 1;
                else z = 0;
            B: if (x) z = 0;
                else z = 1;
            default: z = 0;
        endcase
    end
endmodule
