module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;
    
parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
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
        default: begin
            next_state = A;
            out = 0;
        end
    endcase
end

endmodule
