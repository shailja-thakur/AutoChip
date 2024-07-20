module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] current_state, next_state;
parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        current_state <= A;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        A: begin
            if (in == 0) begin
                next_state = A;
                out = 0;
            end
            else begin
                next_state = B;
                out = 0;
            end
        end
        B: begin
            if (in == 0) begin
                next_state = C;
                out = 0;
            end
            else begin
                next_state = B;
                out = 0;
            end
        end
        C: begin
            if (in == 0) begin
                next_state = A;
                out = 0;
            end
            else begin
                next_state = D;
                out = 0;
            end
        end
        D: begin
            if (in == 0) begin
                next_state = C;
                out = 1;
            end
            else begin
                next_state = B;
                out = 1;
            end
        end
        default: begin
            next_state = A;
            out = 0;
        end
    endcase
end

endmodule
