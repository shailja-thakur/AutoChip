module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

localparam A = 2'b00, B = 2'b01;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= B;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        A: begin
            if (in) begin
                next_state = A;
            end
            else begin
                next_state = B;
            end
        end
        B: begin
            if (in) begin
                next_state = B;
            end
            else begin
                next_state = A;
            end
        end
        default: begin
            next_state = B;
        end
    endcase
end

always @(*) begin
    if (state == B) begin
        out = 1'b1;
    end
    else begin
        out = 1'b0;
    end
end

endmodule
