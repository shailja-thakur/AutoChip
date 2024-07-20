module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

localparam A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;
reg [2:0] state, next_state;

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
                z = 0;
            end
            else begin
                next_state = A;
                z = 0;
            end
        end
        B: begin
            if (w == 0) begin
                next_state = C;
                z = 0;
            end
            else begin
                next_state = D;
                z = 0;
            end
        end
        C: begin
            if (w == 0) begin
                next_state = E;
                z = 0;
            end
            else begin
                next_state = D;
                z = 0;
            end
        end
        D: begin
            if (w == 0) begin
                next_state = F;
                z = 0;
            end
            else begin
                next_state = A;
                z = 0;
            end
        end
        E: begin
            if (w == 0) begin
                next_state = E;
                z = 1;
            end
            else begin
                next_state = D;
                z = 1;
            end
        end
        F: begin
            if (w == 0) begin
                next_state = C;
                z = 1;
            end
            else begin
                next_state = D;
                z = 1;
            end
        end
        default: begin
            next_state = A;
            z = 0;
        end
    endcase
end

endmodule
