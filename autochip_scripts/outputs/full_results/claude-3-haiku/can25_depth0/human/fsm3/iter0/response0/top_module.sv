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
            next_state = (in) ? B : A;
            out = 0;
        end
        B: begin
            next_state = (in) ? B : C;
            out = 0;
        end
        C: begin
            next_state = (in) ? D : A;
            out = 0;
        end
        D: begin
            next_state = (in) ? B : C;
            out = 1;
        end
    endcase
end

endmodule
