module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    reg [1:0] state, next_state;
    parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

    always @(*) begin
        case (state)
            A: next_state = (in) ? B : A;
            B: next_state = (in) ? B : C;
            C: next_state = (in) ? D : A;
            D: next_state = (in) ? B : C;
            default: next_state = A;
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
            out <= 1'b0;
        end else begin
            state <= next_state;
            out <= (state == D) ? 1'b1 : 1'b0;
        end
    end

endmodule
