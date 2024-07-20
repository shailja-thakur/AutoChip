module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg state, next_state;
parameter A = 1'b0, B = 1'b1;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= B;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        B: begin
            if (in == 0) begin
                next_state = A;
                out = 0;
            end
            else begin
                next_state = B;
                out = 1;
            end
        end
        A: begin
            if (in == 0) begin
                next_state = B;
                out = 0;
            end
            else begin
                next_state = A;
                out = 0;
            end
        end
        default: begin
            next_state = B;
            out = 0;
        end
    endcase
end

endmodule
