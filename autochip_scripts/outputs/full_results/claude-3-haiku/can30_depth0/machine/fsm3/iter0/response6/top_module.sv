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
            if (in) begin
                next_state = B;
            end
            else begin
                next_state = A;
            end
        end
        B: begin
            if (in) begin
                next_state = B;
            end
            else begin
                next_state = C;
            end
        end
        C: begin
            if (in) begin
                next_state = D;
            end
            else begin
                next_state = A;
            end
        end
        D: begin
            if (in) begin
                next_state = B;
            end
            else begin
                next_state = C;
            end
        end
        default: begin
            next_state = A;
        end
    endcase
end

always @(state) begin
    case (state)
        D: out = 1'b1;
        default: out = 1'b0;
    endcase
end

endmodule
