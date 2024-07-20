module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    localparam B = 1'b0,
               A = 1'b1;

    reg state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            B: next_state = (in) ? B : A;
            A: next_state = (in) ? A : B;
            default: next_state = B;
        endcase
    end

    // State register and output logic
    always @(posedge clk) begin
        if (reset) begin
            state <= B;
            out <= 1'b1;
        end else begin
            state <= next_state;
            case (next_state)
                B: out <= 1'b1;
                A: out <= 1'b0;
            endcase
        end
    end

endmodule
