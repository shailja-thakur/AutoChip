module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the states
parameter [1:0] INIT = 2'd0, COMPUTE = 2'd1, DONE = 2'd2;
reg [1:0] state, next_state;
reg [7:0] accumulator;
reg sign_bit;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= INIT;
        accumulator <= 8'b0;
        sign_bit <= 1'b0;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
        case (state)
            INIT: begin
                accumulator <= 8'b0;
                sign_bit <= 1'b0;
                z <= 1'b0;
            end
            COMPUTE: begin
                accumulator <= {accumulator[6:0], x};
                sign_bit <= accumulator[7];
                z <= ~sign_bit ? accumulator[7:0] : ~accumulator + 1'b1;
            end
            DONE: begin
                z <= ~sign_bit ? accumulator[7:0] : ~accumulator + 1'b1;
            end
        endcase
    end
end

always @(*) begin
    case (state)
        INIT: begin
            next_state = ~areset ? COMPUTE : INIT;
        end
        COMPUTE: begin
            next_state = areset ? DONE : COMPUTE;
        end
        DONE: begin
            next_state = INIT;
        end
        default: begin
            next_state = INIT;
        end
    endcase
end

endmodule
