module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state, next_state;
localparam A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

// State transition logic
always @(*)
begin
    case (state)
        A: begin
            if (in == 1'b0)
                next_state = A;
            else
                next_state = B;
        end
        B: begin
            if (in == 1'b0)
                next_state = C;
            else
                next_state = B;
        end
        C: begin
            if (in == 1'b0)
                next_state = A;
            else
                next_state = D;
        end
        D: begin
            if (in == 1'b0)
                next_state = C;
            else
                next_state = B;
        end
    endcase
end

// Output logic
always @(*)
begin
    case (state)
        A, B, C: out = 1'b0;
        D: out = 1'b1;
    endcase
end

// State register
always @(posedge clk or posedge reset)
begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

endmodule
