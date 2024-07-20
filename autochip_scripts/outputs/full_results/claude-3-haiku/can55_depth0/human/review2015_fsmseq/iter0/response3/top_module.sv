module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

// Define the states of the FSM
localparam [1:0] 
    STATE_IDLE = 2'b00,
    STATE_S1 = 2'b01, 
    STATE_S2 = 2'b10,
    STATE_S3 = 2'b11;

// State register
reg [1:0] state, next_state;

// State update logic
always @(posedge clk) begin
    if (reset) begin
        state <= STATE_IDLE;
        start_shifting <= 1'b0;
    end
    else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (state)
        STATE_IDLE: begin
            if (data == 1'b1)
                next_state = STATE_S1;
            else
                next_state = STATE_IDLE;
        end
        STATE_S1: begin
            if (data == 1'b1)
                next_state = STATE_S2;
            else
                next_state = STATE_IDLE;
        end
        STATE_S2: begin
            if (data == 1'b0)
                next_state = STATE_S3;
            else
                next_state = STATE_IDLE;
        end
        STATE_S3: begin
            if (data == 1'b1) begin
                next_state = STATE_S1;
                start_shifting <= 1'b1; // Set start_shifting to 1 when the sequence is found
            end
            else
                next_state = STATE_IDLE;
        end
        default: begin
            next_state = STATE_IDLE;
            start_shifting <= 1'b0;
        end
    endcase
end

endmodule
