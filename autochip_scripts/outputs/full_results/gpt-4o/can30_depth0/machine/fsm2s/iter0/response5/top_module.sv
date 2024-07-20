module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    reg state;
    parameter A = 1'b0, B = 1'b1;

    // State Transition Logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else begin
            case (state)
                A: state <= (j) ? B : A;
                B: state <= (k) ? A : B;
                default: state <= A;
            endcase
        end
    end

    // Output Logic
    always @(state) begin
        case (state)
            A: out <= 1'b0;
            B: out <= 1'b1;
            default: out <= 1'b0;
        endcase
    end

endmodule
