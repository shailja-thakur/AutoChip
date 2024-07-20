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
            if (in == 0) begin
                next_state = B;
                out = 0;
            end
            else begin
                next_state = A;
                out = 0;
            end
        end
        B: begin
            if (in == 0) begin
                next_state = B;
                out = 1;
            end
            else begin
                next_state = A;
                out = 1;
            end
        end
    endcase
end

endmodule
