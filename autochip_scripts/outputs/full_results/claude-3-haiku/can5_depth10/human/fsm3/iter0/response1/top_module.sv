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
            if (in == 1'b0) next_state = A;
            else next_state = B;
            out = 1'b0;
        end
        B: begin
            if (in == 1'b0) next_state = C;
            else next_state = B;
            out = 1'b0;
        end
        C: begin
            if (in == 1'b0) next_state = A;
            else next_state = D;
            out = 1'b0;
        end
        D: begin
            if (in == 1'b0) next_state = C;
            else next_state = B;
            out = 1'b1;
        end
        default: begin
            next_state = A;
            out = 1'b0;
        end
    endcase
end

endmodule
