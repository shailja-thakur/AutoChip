module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the states for the state machine
localparam [1:0] 
    IDLE = 2'b00,
    COMPUTE = 2'b01,
    OUTPUT = 2'b10;

// Declare state registers and signal variables
reg [1:0] state, next_state;
reg [3:0] count;
reg [7:0] result;

// Next state logic
always @(*) begin
    case (state)
        IDLE: begin
            if (!areset) begin
                next_state = COMPUTE;
            end else begin
                next_state = IDLE;
            end
        end
        COMPUTE: begin
            if (count == 4'd0) begin
                next_state = OUTPUT;
            end else begin
                next_state = COMPUTE;
            end
        end
        OUTPUT: begin
            if (areset) begin
                next_state = IDLE;
            end else begin
                next_state = OUTPUT;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

// State register update
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
        count <= 4'd8;
        result <= 8'd0;
        z <= 1'b0;
    end else begin
        state <= next_state;
        case (state)
            IDLE: begin
                count <= 4'd8;
                result <= 8'd0;
            end
            COMPUTE: begin
                count <= count - 1;
                result <= {result[6:0], x};
            end
            OUTPUT: begin
                z <= (result == 8'b00000000) ? 8'd0 : (~result[7] ? result[7:0] : (result[7:0] ^ 8'b11111111) + 1);
            end
        endcase
    end
end

endmodule
