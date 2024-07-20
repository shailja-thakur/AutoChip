module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the states of the Moore state machine
localparam [1:0] 
    IDLE = 2'b00,
    COMPUTE = 2'b01,
    DONE = 2'b10;

reg [1:0] state, next_state;
reg [7:0] accumulator;
reg [3:0] bit_count;

// Next state logic
always @(*) begin
    case (state)
        IDLE: begin
            if (~areset) begin
                next_state = COMPUTE;
            end else begin
                next_state = IDLE;
            end
        end
        COMPUTE: begin
            if (bit_count == 4'd8) begin
                next_state = DONE;
            end else begin
                next_state = COMPUTE;
            end
        end
        DONE: begin
            if (areset) begin
                next_state = IDLE;
            end else begin
                next_state = DONE;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

// State update logic
always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        accumulator <= 0;
        bit_count <= 0;
        z <= 0;
    end else begin
        state <= next_state;
        case (state)
            IDLE: begin
                // Do nothing
            end
            COMPUTE: begin
                accumulator <= {accumulator[6:0], x};
                bit_count <= bit_count + 1;
                z <= ~accumulator[7];
            end
            DONE: begin
                accumulator <= ~accumulator + 1;
                z <= accumulator[7];
            end
            default: begin
                // Do nothing
            end
        endcase
    end
end

endmodule
