module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

// Define the states of the finite state machine
parameter [1:0] IDLE = 2'b00, MAYBE_DISC = 2'b01, MAYBE_FLAG = 2'b10, MAYBE_ERR = 2'b11;

// Internal state register
reg [1:0] state, next_state;

// Next state logic
always @(*) begin
    case (state)
        IDLE: begin
            if (in == 1'b0) begin
                next_state = IDLE;
            end else begin
                next_state = MAYBE_DISC;
            end
        end
        MAYBE_DISC: begin
            if (in == 1'b0) begin
                next_state = IDLE;
            end else begin
                next_state = MAYBE_FLAG;
            end
        end
        MAYBE_FLAG: begin
            if (in == 1'b0) begin
                next_state = IDLE;
            end else begin
                next_state = MAYBE_ERR;
            end
        end
        MAYBE_ERR: begin
            if (in == 1'b0) begin
                next_state = IDLE;
            end else begin
                next_state = MAYBE_ERR;
            end
        end
    endcase
end

// Output logic
always @(*) begin
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;
    case (state)
        MAYBE_DISC: begin
            disc = 1'b1;
        end
        MAYBE_FLAG: begin
            flag = 1'b1;
        end
        MAYBE_ERR: begin
            err = 1'b1;
        end
    endcase
end

// State update logic
always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

endmodule
