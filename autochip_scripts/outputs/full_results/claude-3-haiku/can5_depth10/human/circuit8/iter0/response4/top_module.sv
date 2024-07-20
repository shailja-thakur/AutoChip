module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg state;
reg next_state;

always @(posedge clock) begin
    state <= next_state;
end

always @(*) begin
    case (state)
        1'b0: begin
            p = 0;
            q = 0;
            if (a == 0) begin
                next_state = 1'b0;
            end else begin
                next_state = 1'b1;
            end
        end
        1'b1: begin
            p = 0;
            q = 1;
            if (a == 0) begin
                next_state = 1'b0;
            end else begin
                next_state = 1'b1;
            end
        end
    endcase
end

endmodule
