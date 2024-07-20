module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

localparam [1:0] 
    A = 2'b00,
    B = 2'b01,
    C = 2'b10;

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
        A: next_state = (s == 1) ? B : A;
        B: next_state = (count == 3) ? A : B;
        default: next_state = A;
    endcase
end

endmodule
