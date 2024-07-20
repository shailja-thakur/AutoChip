module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state, next_state;
parameter A = 2'b00, B = 2'b01, C = 2'b10;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end
    else begin
        state <= next_state;
    end
end

reg [1:0] w_count;

always @(state, s, w) begin
    case (state)
        A: begin
            if (s) begin
                next_state = B;
                w_count = 0;
            end
            else begin
                next_state = A;
                w_count = 0;
            end
            z = 1'b0;
        end
        B: begin
            if (w) begin
                w_count = w_count + 1;
            end
            if (w_count == 2) begin
                next_state = C;
                z = 1'b1;
            end
            else if (w_count == 3) begin
                next_state = B;
                w_count = 0;
                z = 1'b0;
            end
            else begin
                next_state = B;
                z = 1'b0;
            end
        end
        C: begin
            next_state = B;
            w_count = 0;
            z = 1'b0;
        end
        default: begin
            next_state = A;
            w_count = 0;
            z = 1'b0;
        end
    endcase
end

endmodule
