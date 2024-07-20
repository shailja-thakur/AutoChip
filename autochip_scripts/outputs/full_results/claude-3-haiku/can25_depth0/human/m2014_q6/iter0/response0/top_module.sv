module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [3:0] state, next_state;
parameter A = 4'b0000, B = 4'b0001, C = 4'b0010, D = 4'b0011,
          E = 4'b0100, F = 4'b0101;

always @(posedge clk or negedge reset) begin
    if (!reset) begin
        state <= A;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        A: begin
            if (w == 0) begin
                next_state = B;
            end
            else begin
                next_state = A;
            end
        end
        B: begin
            if (w == 0) begin
                next_state = C;
            end
            else begin
                next_state = D;
            end
        end
        C: begin
            if (w == 0) begin
                next_state = E;
            end
            else begin
                next_state = D;
            end
        end
        D: begin
            if (w == 0) begin
                next_state = F;
            end
            else begin
                next_state = A;
            end
        end
        E: begin
            if (w == 0) begin
                next_state = E;
            end
            else begin
                next_state = D;
            end
        end
        F: begin
            if (w == 0) begin
                next_state = C;
            end
            else begin
                next_state = D;
            end
        end
        default: begin
            next_state = A;
        end
    endcase
end

always @(state) begin
    case (state)
        E, F: begin
            z = 1;
        end
        default: begin
            z = 0;
        end
    endcase
end

endmodule
