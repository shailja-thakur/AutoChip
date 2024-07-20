module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg state, next_state;
parameter A = 1'b0, B = 1'b1;

always @(posedge clk) begin
    if (reset) begin
        state <= B;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        B: begin
            out = 1'b1;
            if (in) begin
                next_state = B;
            end
            else begin
                next_state = A;
            end
        end
        A: begin
            out = 1'b0;
            if (in) begin
                next_state = A;
            end
            else begin
                next_state = B;
            end
        end
        default: begin
            out = 1'b0;
            next_state = B;
        end
    endcase
end

endmodule
