module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state, next_state;
localparam A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

always @(posedge clk, posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        A: begin
            out = 0;
            next_state = (in) ? B : A;
        end
        B: begin
            out = 0;
            next_state = (in) ? B : C;
        end
        C: begin
            out = 0;
            next_state = (in) ? D : A;
        end
        D: begin
            out = 1;
            next_state = (in) ? B : C;
        end
    endcase
end

endmodule
