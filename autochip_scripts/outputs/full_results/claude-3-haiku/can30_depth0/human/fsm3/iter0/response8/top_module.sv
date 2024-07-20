module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg [1:0] current_state, next_state;

parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= A;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        A: begin
            if (in) begin
                next_state = B;
            end
            else begin
                next_state = A;
            end
            out = 0;
        end
        B: begin
            if (in) begin
                next_state = B;
            end
            else begin
                next_state = C;
            end
            out = 0;
        end
        C: begin
            if (in) begin
                next_state = D;
            end
            else begin
                next_state = A;
            end
            out = 0;
        end
        D: begin
            if (in) begin
                next_state = B;
            end
            else begin
                next_state = C;
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
