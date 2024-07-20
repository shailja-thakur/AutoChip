module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;

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
            if (x) begin
                next_state = C;
            end
            else begin
                next_state = A;
            end
        end
        B: begin
            if (x) begin
                next_state = B;
            end
            else begin
                next_state = C;
            end
        end
        C: begin
            if (x) begin
                next_state = B;
            end
            else begin
                next_state = C;
            end
        end
        default: begin
            next_state = A;
        end
    endcase
end

always @(*) begin
    if (state == C) begin
        z = 1'b1;
    end
    else begin
        z = 1'b0;
    end
end

endmodule
