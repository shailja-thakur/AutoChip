module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state, next_state;
parameter [1:0] A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
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
            out = 1'b0;
        end
        B: begin
            if (in) begin
                next_state = B;
            end
            else begin
                next_state = C;
            end
            out = 1'b0;
        end
        C: begin
            if (in) begin
                next_state = D;
            end
            else begin
                next_state = A;
            end
            out = 1'b0;
        end
        D: begin
            if (in) begin
                next_state = B;
            end
            else begin
                next_state = C;
            end
            out = 1'b1;
        end
        default: begin
            next_state = A;
            out = 1'b0;
        end
    endcase
end

endmodule
