module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter A = 2'b01;
parameter B = 2'b10;

reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        A: begin
            if (x == 0) begin
                next_state = A;
                z = 0;
            end
            else begin
                next_state = B;
                z = 1;
            end
        end
        B: begin
            if (x == 0) begin
                next_state = B;
                z = 1;
            end
            else begin
                next_state = B;
                z = 0;
            end
        end
        default: begin
            next_state = A;
            z = 0;
        end
    endcase
end

endmodule
