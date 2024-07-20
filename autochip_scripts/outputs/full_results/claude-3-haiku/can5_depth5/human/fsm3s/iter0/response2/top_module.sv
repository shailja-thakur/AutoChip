module top_module (
    input clk,
    input in,
    input reset,
    output out
);

reg [1:0] current_state, next_state;

localparam A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3;

always @(posedge clk) begin
    if (reset) begin
        current_state <= A;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        A: begin
            if (in == 0) begin
                next_state = A;
            end
            else begin
                next_state = B;
            end
            out = 0;
        end
        B: begin
            if (in == 0) begin
                next_state = C;
            end
            else begin
                next_state = B;
            end
            out = 0;
        end
        C: begin
            if (in == 0) begin
                next_state = A;
            end
            else begin
                next_state = D;
            end
            out = 0;
        end
        D: begin
            if (in == 0) begin
                next_state = C;
            end
            else begin
                next_state = B;
            end
            out = 1;
        end
    endcase
end

endmodule
