module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state, next_state;
localparam A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

// State transition logic
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
    endcase
end

// Output logic
assign out = (state == D);

// State register
always @(posedge clk or posedge reset) begin
    if (reset) state <= A;
    else state <= next_state;
end

endmodule
