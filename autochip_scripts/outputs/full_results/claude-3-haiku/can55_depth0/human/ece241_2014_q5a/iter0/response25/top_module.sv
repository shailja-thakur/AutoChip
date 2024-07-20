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
    DONE = 2'b11;

// Internal variables
reg [1:0] state;
reg [7:0] accumulator;
reg [3:0] bit_count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        accumulator <= 8'b0;
        bit_count <= 4'b0;
        z <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (!areset) begin
                    state <= COMPUTE;
                    accumulator <= 8'b0;
                    bit_count <= 4'b0;
                end
            end
            COMPUTE: begin
                accumulator <= {accumulator[6:0], x};
                bit_count <= bit_count + 1;
                if (bit_count == 4'd7) begin
                    state <= DONE;
                    z <= ~accumulator + 1;
                end
            end
            DONE: begin
                if (areset) begin
                    state <= IDLE;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
