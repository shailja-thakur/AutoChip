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
reg [2:0] ones_count;

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
            if (ones_count == 6)
                next_state = IDLE;
            else if (in)
                next_state = WAIT_FLAG;
            else
                next_state = WAIT_ERR;
        end
        WAIT_ERR: begin
            if (ones_count == 7)
                next_state = IDLE;
            else if (in)
                next_state = WAIT_ERR;
            else
                next_state = WAIT_FLAG;
        end
        default:
            next_state = IDLE;
    endcase
end

// Sequential logic for current state update
always @(posedge clk) begin
    if (reset) begin
        current_state <= IDLE;
        ones_count <= 0;
    end
    else begin
        current_state <= next_state;
        if (in)
            ones_count <= ones_count + 1;
        else
            ones_count <= 0;
    end
end

// Output logic
always @(*) begin
    disc = 0;
    flag = 0;
    err = 0;
    case (current_state)
        WAIT_DISC: begin
            if (ones_count == 5)
                disc = 1;
        end
        WAIT_FLAG: begin
            if (ones_count == 6)
                flag = 1;
        end
        WAIT_ERR: begin
            if (ones_count == 7)
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
