module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

// Define the states of the finite state machine
localparam [2:0] IDLE = 3'b000,
                 DISC = 3'b001,
                 FLAG = 3'b010,
                 ERR  = 3'b011;

// Declare the state register
reg [2:0] state, next_state;

// Update the state register on each clock cycle
always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

// Combinational logic to determine the next state and set the output signals
always @(*) begin
    next_state = state;
    disc = 0;
    flag = 0;
    err = 0;

    case (state)
        IDLE: begin
            if (in == 1'b1) begin
                next_state = DISC;
            end
        end
        DISC: begin
            if (in == 1'b1) begin
                next_state = FLAG;
                disc = 1;
            end else begin
                next_state = IDLE;
            end
        end
        FLAG: begin
            if (in == 1'b1) begin
                next_state = ERR;
                flag = 1;
            end else begin
                next_state = IDLE;
            end
        end
        ERR: begin
            if (in == 1'b1) begin
                err = 1;
            end else begin
                next_state = IDLE;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
