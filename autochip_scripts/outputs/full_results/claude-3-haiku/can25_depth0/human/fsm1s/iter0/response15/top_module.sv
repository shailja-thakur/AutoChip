module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg current_state, next_state;
parameter A = 1'b0, B = 1'b1;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= B;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        A: begin
            out = 1'b0;
            if (in == 1'b0) begin
                next_state = B;
            end
            else begin
                next_state = A;
            end
        end
        B: begin
            out = 1'b1;
            if (in == 1'b0) begin
                next_state = B;
            end
            else begin
                next_state = A;
            end
        end
        default: begin
            out = 1'b0;
            next_state = B;
        end
    endcase
end

endmodule
