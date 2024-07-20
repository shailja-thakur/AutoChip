module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg [1:0] state, next_state;

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @(state or in) begin
    case (state)
        A: begin
            if (in) begin
                next_state = B;
                out = 0;
            end else begin
                next_state = A;
                out = 0;
            end
        end
        B: begin
            if (in) begin
                next_state = B;
                out = 0;
            end else begin
                next_state = C;
                out = 0;
            end
        end
        C: begin
            if (in) begin
                next_state = D;
                out = 0;
            end else begin
                next_state = A;
                out = 0;
            end
        end
        D: begin
            if (in) begin
                next_state = B;
                out = 1;
            end else begin
                next_state = C;
                out = 1;
            end
        end
    endcase
end

endmodule
