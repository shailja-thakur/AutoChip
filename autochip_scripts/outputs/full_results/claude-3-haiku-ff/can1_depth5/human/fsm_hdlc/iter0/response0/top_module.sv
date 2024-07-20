module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

// Define the state encodings
localparam [2:0] IDLE = 3'b000,
                 WAIT_DISC = 3'b001,
                 WAIT_FLAG = 3'b010,
                 WAIT_ERR = 3'b011;

// Declare the current and next state registers
reg [2:0] current_state, next_state;

// Combinational logic for next state
always @(*) begin
    case (current_state)
        IDLE: begin
            if (in)
                next_state = WAIT_DISC;
            else
                next_state = IDLE;
        end
        WAIT_DISC: begin
            if (in)
                next_state = WAIT_DISC;
            else
                next_state = WAIT_FLAG;
        end
        WAIT_FLAG: begin
            if (in)
                next_state = WAIT_FLAG;
            else
                next_state = IDLE;
        end
        WAIT_ERR: begin
            if (in)
                next_state = WAIT_ERR;
            else
                next_state = IDLE;
        end
        default:
            next_state = IDLE;
    endcase
end

// Sequential logic for current state update
always @(posedge clk) begin
    if (reset)
        current_state <= IDLE;
    else
        current_state <= next_state;
end

// Output logic
always @(*) begin
    disc = 0;
    flag = 0;
    err = 0;
    case (current_state)
        WAIT_DISC: begin
            disc = 1;
        end
        WAIT_FLAG: begin
            flag = 1;
        end
        WAIT_ERR: begin
            err = 1;
        end
        default: begin
            disc = 0;
            flag = 0;
            err = 0;
        end
    endcase
end

endmodule
