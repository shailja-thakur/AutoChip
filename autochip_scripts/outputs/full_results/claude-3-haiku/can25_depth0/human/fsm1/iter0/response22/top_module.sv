module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg current_state, next_state;
parameter A = 1'b0, B = 1'b1;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        current_state <= B;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        A: begin
            if (in) begin
                next_state = A;
            end
            else begin
                next_state = B;
            end
        end
        B: begin
            if (in) begin
                next_state = B;
            end
            else begin
                next_state = A;
            end
        end
        default: begin
            next_state = B;
        end
    endcase
end

assign out = (current_state == A) ? 1'b0 : 1'b1;

endmodule
