module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state, next_state;

localparam A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3;

// State register
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

// Next state logic
always @(*) begin
    case (state)
        A: begin
            if (in)
                next_state = B;
            else
                next_state = A;
        end
        B: begin
            if (in)
                next_state = B;
            else
                next_state = C;
        end
        C: begin
            if (in)
                next_state = D;
            else
                next_state = A;
        end
        D: begin
            if (in)
                next_state = B;
            else
                next_state = C;
        end
    endcase
end

// Output logic
always @(*) begin
    out = (state == D);
end

endmodule
