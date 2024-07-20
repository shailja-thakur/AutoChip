module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

localparam A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
reg [1:0] state, next_state;
reg [1:0] w_count;

always @(posedge clk) begin
    if (reset) begin
        state <= A;
        w_count <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        w_count <= (state == B) ? w_count + (w ? 1 : 0) : 0;
        z <= (state == D && w_count == 2) ? 1 : 0;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        A: next_state = (s) ? B : A;
        B: next_state = (w_count == 3) ? C : B;
        C: next_state = D;
        D: next_state = B;
    endcase
end

endmodule
