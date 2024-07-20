module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    parameter A = 2'b00, B = 2'b01, C = 2'b10;
    reg [1:0] state, next_state;
    reg [1:0] w_count;

    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b00;
            z <= 1'b0;
        end
        else begin
            state <= next_state;
            w_count <= (state == B) ? w_count + {1'b0, w} : 2'b00;
            z <= (state == B && w_count == 2'b10) ? 1'b1 : 1'b0;
        end
    end

    always @(*) begin
        case (state)
            A: next_state = (s) ? B : A;
            B: next_state = (w_count == 2'b11) ? A : B;
            default: next_state = A;
        endcase
    end

endmodule
