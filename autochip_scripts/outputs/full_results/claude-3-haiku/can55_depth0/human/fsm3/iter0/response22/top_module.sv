module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

localparam [1:0] 
    A = 2'b00,
    B = 2'b01, 
    C = 2'b10,
    D = 2'b11;

always @(*) begin
    case (state)
        A: begin
            if (in == 1'b0) next_state = A;
            else next_state = B;
            out = 1'b0;
        end
        B: begin
            if (in == 1'b0) next_state = C;
            else next_state = B;
            out = 1'b0;
        end
        C: begin
            if (in == 1'b0) next_state = A;
            else next_state = D;
            out = 1'b0;
        end
        D: begin
            if (in == 1'b0) next_state = C;
            else next_state = B;
            out = 1'b1;
        end
        default: begin
            next_state = A;
            out = 1'b0;
        end
    endcase
end

always @(posedge clk, posedge areset) begin
    if (areset) state <= A;
    else state <= next_state;
end

endmodule
