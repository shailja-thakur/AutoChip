module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] current_state, next_state;

localparam A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

always @(posedge clk or negedge areset) begin
    if (!areset)
        current_state <= A;
    else
        current_state <= next_state;
end

always @(*) begin
    case (current_state)
        A: begin
            if (in)
                next_state = B;
            else
                next_state = A;
            out = 0;
        end
        B: begin
            if (in)
                next_state = B;
            else
                next_state = C;
            out = 0;
        end
        C: begin
            if (in)
                next_state = D;
            else
                next_state = A;
            out = 0;
        end
        D: begin
            if (in)
                next_state = B;
            else
                next_state = C;
            out = 1;
        end
    endcase
end

endmodule
