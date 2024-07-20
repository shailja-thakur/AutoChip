module top_module (
    input clk,
    input in,
    input reset,
    output out
);

reg [1:0] state, next_state;

parameter B = 2'b00;
parameter A = 2'b01;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= B;
    else
        state <= next_state;
end

always @(state or in) begin
    case (state)
        B: begin
            if (in)
                next_state = B;
            else
                next_state = A;
            out = 1;
        end
        A: begin
            if (in)
                next_state = A;
            else
                next_state = B;
            out = 0;
        end
    endcase
end

endmodule
