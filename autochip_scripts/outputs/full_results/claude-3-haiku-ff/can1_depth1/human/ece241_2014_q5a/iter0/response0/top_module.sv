module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter IDLE = 2'b00, COMPUTE = 2'b01, DONE = 2'b11;
reg [1:0] state, next_state;
reg [7:0] accumulator;
reg [3:0] bit_count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        accumulator <= 0;
        bit_count <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                z <= 0;
                bit_count <= 0;
                accumulator <= 0;
            end
            COMPUTE: begin
                accumulator <= {accumulator[6:0], x};
                bit_count <= bit_count + 1;
                if (bit_count == 7) begin
                    next_state <= DONE;
                    z <= ~accumulator + 1;
                end
            end
            DONE: begin
                z <= ~accumulator + 1;
            end
        endcase
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            next_state = (x) ? COMPUTE : IDLE;
        end
        COMPUTE: begin
            next_state = COMPUTE;
        end
        DONE: begin
            next_state = (areset) ? IDLE : DONE;
        end
    endcase
end

endmodule
