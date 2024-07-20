module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state, next_state;
parameter A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3;

always @(posedge clk) begin
    if (reset) begin
        state <= A;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        A: begin
            next_state = (in) ? B : A;
            out = 1'b0;
        end
        B: begin
            next_state = (in) ? B : C;
            out = 1'b0;
        end
        C: begin
            next_state = (in) ? D : A;
            out = 1'b0;
        end
        D: begin
            next_state = (in) ? B : C;
            out = 1'b1;
        end
        default: begin
            next_state = A;
            out = 1'b0;
        end
    endcase
end

endmodule
