module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

localparam A = 2'b00, B = 2'b01, C = 2'b10;
reg [1:0] state, next_state;
reg [1:0] count;

always @(posedge clk) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        A: begin
            if (s)
                next_state = B;
            else
                next_state = A;
            z = 0;
        end
        B: begin
            if (count == 2'b10 && w)
                next_state = C;
            else if (count == 2'b11)
                next_state = B;
            else
                next_state = B;
            z = 0;
        end
        C: begin
            if (count == 2'b10 && !w)
                next_state = B;
            else if (count == 2'b11)
                next_state = C;
            else
                next_state = C;
            z = 1;
        end
        default:
            next_state = A;
    endcase
end

always @(posedge clk) begin
    if (reset)
        count <= 0;
    else if (state == B || state == C)
        count <= count + 1;
    else
        count <= 0;
end

endmodule
