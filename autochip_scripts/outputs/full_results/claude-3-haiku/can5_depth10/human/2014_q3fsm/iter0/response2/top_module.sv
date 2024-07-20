module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

localparam A = 2'd0, B = 2'd1, C = 2'd2;
reg [1:0] state, next_state;
reg [1:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= A;
        count <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        count <= (state == B) ? count + 1 : 0;
        z <= (state == B && count == 2) ? 1 : 0;
    end
end

always @(*) begin
    case (state)
        A: begin
            next_state = (s == 1) ? B : A;
        end
        B: begin
            next_state = (count == 3) ? A : B;
        end
        default: begin
            next_state = A;
        end
    endcase
end

endmodule
