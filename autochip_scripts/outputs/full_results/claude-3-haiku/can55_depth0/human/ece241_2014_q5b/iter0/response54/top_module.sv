module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [1:0] state, next_state;
parameter A = 2'b01, B = 2'b10;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        A: begin
            if (x == 1'b0) begin
                next_state = A;
                z = 1'b0;
            end else begin
                next_state = B;
                z = 1'b1;
            end
        end
        B: begin
            if (x == 1'b0) begin
                next_state = B;
                z = 1'b1;
            end else begin
                next_state = B;
                z = 1'b0;
            end
        end
        default: begin
            next_state = A;
            z = 1'b0;
        end
    endcase
end

endmodule
