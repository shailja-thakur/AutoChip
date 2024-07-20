module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

// State encoding
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// State transition logic
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        A: begin
            if (in == 0)
                next_state = A;
            else
                next_state = B;
            out = 0;
        end
        B: begin
            if (in == 0)
                next_state = C;
            else
                next_state = B;
            out = 0;
        end
        C: begin
            if (in == 0)
                next_state = A;
            else
                next_state = D;
            out = 0;
        end
        D: begin
            if (in == 0)
                next_state = C;
            else
                next_state = B;
            out = 1;
        end
    endcase
end

endmodule
