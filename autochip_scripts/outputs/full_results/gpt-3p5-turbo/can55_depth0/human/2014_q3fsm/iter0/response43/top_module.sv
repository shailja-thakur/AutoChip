module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state, next_state;
parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @(state or w) begin
    next_state = state;
    case (state)
        A: begin
            if (s == 1) begin
                next_state = B;
            end else begin
                next_state = A;
            end
        end
        B: begin
            if (w == 1'b1) begin
                next_state = B;
            end else begin
                next_state = (w == 2'b11) ? B : A;
            end
        end
    end
end

always @(posedge clk) begin
    if (state == A) begin
        z <= 1'b0;
    end else begin
        z <= (w == 2'b11) ? 1'b1 : 1'b0;
    end
end

endmodule
