module top_module (
    input clk,
    input in,
    input areset,
    output out
);

localparam A = 0, B = 1;
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
            end
            else begin
                next_state = A;
            end
            out = 0;
        end
        B: begin
            if (in == 0) begin
                next_state = B;
            end
            else begin
                next_state = A;
            end
            out = 1;
        end
        default: begin
            next_state = B;
            out = 1;
        end
    endcase
end

endmodule
