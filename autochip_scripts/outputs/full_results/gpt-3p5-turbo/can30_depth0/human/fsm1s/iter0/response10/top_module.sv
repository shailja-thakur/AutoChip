module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state, next_state;

localparam B = 2'b00;
localparam A = 2'b01;

always @(posedge clk) begin
    if (reset)
        state <= B;
    else
        state <= next_state;
end

always @(state or in) begin
    case (state)
        B: begin
            if (in == 1'b0)
                next_state = A;
            else
                next_state = B;
            out = 1'b1;
        end
        A: begin
            if (in == 1'b0)
                next_state = B;
            else
                next_state = A;
            out = 1'b0;
        end
    endcase
end

endmodule
