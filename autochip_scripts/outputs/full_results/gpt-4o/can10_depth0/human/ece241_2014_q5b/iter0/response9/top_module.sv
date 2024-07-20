module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

typedef enum logic [1:0] {A = 2'b01, B = 2'b10} state_t;
state_t state, next_state;

always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always_comb begin
    case (state)
        A: begin
            if (x) begin
                next_state = B;
                z = 1'b1;
            end else begin
                next_state = A;
                z = 1'b0;
            end
        end
        B: begin
            if (x) begin
                next_state = B;
                z = 1'b0;
            end else begin
                next_state = B;
                z = 1'b1;
            end
        end
        default: begin
            next_state = A;
            z = 1'b0;
        end
    endcase
end

endmodule
