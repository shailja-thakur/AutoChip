module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        A: begin
            out = 1'b0;
            if (in == 1'b0)
                next_state = A;
            else
                next_state = B;
        end
        B: begin
            out = 1'b0;
            if (in == 1'b0)
                next_state = C;
            else
                next_state = B;
        end
        C: begin
            out = 1'b0;
            if (in == 1'b0)
                next_state = A;
            else
                next_state = D;
        end
        D: begin
            out = 1'b1;
            if (in == 1'b0)
                next_state = C;
            else
                next_state = B;
        end
        default: begin
            out = 1'b0;
            next_state = A;
        end
    endcase
end

endmodule
