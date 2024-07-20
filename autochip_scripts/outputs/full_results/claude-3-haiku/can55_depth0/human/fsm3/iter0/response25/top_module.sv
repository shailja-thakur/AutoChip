module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

localparam A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

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
            out = 0;
            if (in == 0) begin
                next_state = A;
            end
            else begin
                next_state = B;
            end
        end
        B: begin
            out = 0;
            if (in == 0) begin
                next_state = C;
            end
            else begin
                next_state = B;
            end
        end
        C: begin
            out = 0;
            if (in == 0) begin
                next_state = A;
            end
            else begin
                next_state = D;
            end
        end
        D: begin
            out = 1;
            if (in == 0) begin
                next_state = C;
            end
            else begin
                next_state = B;
            end
        end
        default: begin
            out = 0;
            next_state = A;
        end
    endcase
end

endmodule
