module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state, next_state;

localparam A = 2'b00,
          B = 2'b01,
          C = 2'b10,
          D = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        A: begin
            out = 0;
            if (in == 0)
                next_state = A;
            else
                next_state = B;
        end
        B: begin
            out = 0;
            if (in == 0)
                next_state = C;
            else
                next_state = B;
        end
        C: begin
            out = 0;
            if (in == 0)
                next_state = A;
            else
                next_state = D;
        end
        D: begin
            out = 1;
            if (in == 0)
                next_state = C;
            else
                next_state = B;
        end
    endcase
end

endmodule
