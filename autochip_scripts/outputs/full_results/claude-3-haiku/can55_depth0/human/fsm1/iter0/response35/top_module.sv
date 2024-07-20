module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

localparam A = 1'b0;
localparam B = 1'b1;

reg state, next_state;

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
        A: begin
            out = 0;
            if (in == 0) begin
                next_state = B;
            end
            else begin
                next_state = A;
            end
        end
        B: begin
            out = 1;
            if (in == 0) begin
                next_state = B;
            end
            else begin
                next_state = A;
            end
        end
        default: begin
            out = 0;
            next_state = B;
        end
    endcase
end

endmodule
