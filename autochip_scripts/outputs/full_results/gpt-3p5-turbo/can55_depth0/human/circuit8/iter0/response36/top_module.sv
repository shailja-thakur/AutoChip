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

always @* begin
    case (state)
        0: begin
            if (a == 1'b1) begin
                next_state = 1;
                p = 1'b0;
                q = 1'b0;
            end else begin
                next_state = 0;
                p = 1'bx;
                q = 1'bx;
            end
        end
        1: begin
            if (a == 1'b1) begin
                next_state = 2;
                p = 1'b1;
                q = 1'b0;
            end else begin
                next_state = 1;
                p = 1'b0;
                q = 1'bx;
            end
        end
        2: begin
            if (a == 1'b1) begin
                next_state = 3;
                p = 1'b1;
                q = 1'bx;
            end else begin
                next_state = 2;
                p = 1'b1;
                q = 1'b0;
            end
        end
        3: begin
            if (a == 1'b1) begin
                next_state = 0;
                p = 1'bx;
                q = 1'bx;
            end else begin
                next_state = 3;
                p = 1'b1;
                q = 1'b1;
            end
       end
    endcase
end

initial begin
    state = 0;
    p = 1'bx;
    q = 1'bx;
end

endmodule
