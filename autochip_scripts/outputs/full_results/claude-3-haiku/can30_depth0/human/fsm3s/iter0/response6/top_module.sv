module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state, next_state;
parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case(state)
        A: begin
            out = 1'b0;
            next_state = (in) ? B : A;
        end
        B: begin
            out = 1'b0;
            next_state = (in) ? B : C;
        end
        C: begin
            out = 1'b0;
            next_state = (in) ? D : A;
        end
        D: begin
            out = 1'b1;
            next_state = (in) ? B : C;
        end
    endcase
end

endmodule
