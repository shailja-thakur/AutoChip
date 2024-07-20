module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state, next_state;
parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100;

always @(posedge clk or posedge reset) begin
    if (reset) begin
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
                next_state = B;
            end
            else begin
                next_state = A;
            end
            z = 1'b0;
        end
        B: begin
            if (x) begin
                next_state = E;
            end
            else begin
                next_state = B;
            end
            z = 1'b0;
        end
        C: begin
            if (x) begin
                next_state = B;
            end
            else begin
                next_state = C;
            end
            z = 1'b0;
        end
        D: begin
            if (x) begin
                next_state = C;
            end
            else begin
                next_state = B;
            end
            z = 1'b1;
        end
        E: begin
            if (x) begin
                next_state = E;
            end
            else begin
                next_state = D;
            end
            z = 1'b1;
        end
        default: begin
            next_state = A;
            z = 1'b0;
        end
    endcase
end

endmodule
