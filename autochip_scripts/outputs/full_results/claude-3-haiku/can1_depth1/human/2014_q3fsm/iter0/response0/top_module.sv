module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

localparam A = 2'b00, B = 2'b01, C = 2'b10;
reg [1:0] state, next_state;
reg [1:0] w_count;

always @(posedge clk) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

always @(*) begin
    next_state = state;
    case (state)
        A: begin
            if (s)
                next_state = B;
            else
                next_state = A;
        end
        B: begin
            if (w_count == 2'b10)
                next_state = C;
            else
                next_state = B;
        end
        C: begin
            z = 1'b1;
            next_state = B;
        end
        default: begin
            z = 1'b0;
            next_state = A;
        end
    endcase
end

always @(posedge clk) begin
    if (reset)
        w_count <= 2'b00;
    else if (state == B)
        w_count <= {w_count[0], w};
    else
        w_count <= 2'b00;
end

endmodule
