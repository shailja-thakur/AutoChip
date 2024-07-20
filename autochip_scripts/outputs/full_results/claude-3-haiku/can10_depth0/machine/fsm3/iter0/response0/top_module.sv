module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

localparam A = 2'b00;
localparam B = 2'b01;
localparam C = 2'b10;
localparam D = 2'b11;

always @(*) begin
    case (state)
        A: begin
            if (in) next_state = B;
            else next_state = A;
        end
        B: begin
            if (in) next_state = B;
            else next_state = C;
        end
        C: begin
            if (in) next_state = D;
            else next_state = A;
        end
        D: begin
            if (in) next_state = B;
            else next_state = C;
        end
        default: next_state = A;
    endcase
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
        out <= 1'b0;
    end
    else begin
        state <= next_state;
        out <= (state == D) ? 1'b1 : 1'b0;
    end
end

endmodule
