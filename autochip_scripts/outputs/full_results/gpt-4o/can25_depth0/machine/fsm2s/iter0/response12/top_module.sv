module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    reg state; // 0 for state A, 1 for state B

    // State encoding
    localparam A = 1'b0;
    localparam B = 1'b1;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            case (state)
                A: if (j) state <= B;
                B: if (k) state <= A;
            endcase
        end
    end

    // Output logic
    always @(state) begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b1;
        endcase
    end

endmodule
