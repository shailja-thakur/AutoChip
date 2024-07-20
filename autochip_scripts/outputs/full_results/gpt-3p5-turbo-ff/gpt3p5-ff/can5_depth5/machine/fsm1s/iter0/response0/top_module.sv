module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

parameter A = 0;
parameter B = 1;

reg state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= B;
    end else begin
        state <= next_state;
    end
end

always @* begin
    case(state)
        A: begin
            if (in) begin
                next_state = A;
            end else begin
                next_state = B;
            end
        end
        B: begin
            if (in) begin
                next_state = B;
            end else begin
                next_state = A;
            end
        end
    endcase
end

assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
