module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the states of the state machine
localparam [1:0] 
    IDLE = 2'b00,
    COMPUTE = 2'b01,
    OUTPUT = 2'b10;

reg [1:0] state, next_state;
reg [7:0] accumulator;
reg negate;

// State transition logic
always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        accumulator <= 8'd0;
        negate <= 1'b0;
    end
    else begin
        state <= next_state;
        if (state == COMPUTE) begin
            accumulator <= {accumulator[6:0], x};
            negate <= ~negate;
        end
    end
end

// Next state logic
always @(*) begin
    case (state)
        IDLE: begin
            next_state = (x) ? COMPUTE : IDLE;
        end
        COMPUTE: begin
            next_state = COMPUTE;
        end
        OUTPUT: begin
            next_state = (areset) ? IDLE : OUTPUT;
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

// Output logic
always @(*) begin
    case (state)
        IDLE: begin
            z = 1'b0;
        end
        COMPUTE: begin
            z = 1'b0;
        end
        OUTPUT: begin
            z = negate ? ~accumulator[7:0] : accumulator[7:0];
        end
        default: begin
            z = 1'b0;
        end
    endcase
end

endmodule
