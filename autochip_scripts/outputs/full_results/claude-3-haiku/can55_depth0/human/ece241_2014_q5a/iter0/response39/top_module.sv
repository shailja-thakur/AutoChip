module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the necessary states
typedef enum reg [1:0] {IDLE, COMPUTE, COMPLETE} state_t;
state_t state, next_state;

// Register to hold the input number
reg [7:0] num;

// Register to hold the 2's complement output
reg [7:0] result;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        num <= 0;
        result <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        if (state == COMPUTE) begin
            num[7:0] <= {num[6:0], x};
            result[7:0] <= {result[6:0], ~x};
        end
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            next_state = (x) ? COMPUTE : IDLE;
            z = 0;
        end
        COMPUTE: begin
            next_state = (num == 8'd255) ? COMPLETE : COMPUTE;
            z = 0;
        end
        COMPLETE: begin
            next_state = IDLE;
            z = result[7];
        end
        default: begin
            next_state = IDLE;
            z = 0;
        end
    endcase
end

endmodule
