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
            if (in == 0) begin
                next_state = A;
            end
            else begin
                next_state = B;
            end
            out = 0;
        end
        B: begin
            if (in == 0) begin
                next_state = C;
            end
            else begin
                next_state = B;
            end
            out = 0;
        end
        C: begin
            if (in == 0) begin
                next_state = A;
            end
            else begin
                next_state = D;
            end
            out = 0;
        end
        D: begin
            if (in == 0) begin
                next_state = C;
            end
            else begin
                next_state = B;
            end
            out = 1;
        end
        default: begin
            next_state = A;
            out = 0;
        end
    endcase
end

endmodule
