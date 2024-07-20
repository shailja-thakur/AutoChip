module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

// Define the states of the finite state machine
parameter IDLE = 3'b000;
parameter DISC = 3'b001;
parameter FLAG = 3'b010;
parameter ERR = 3'b011;

// Internal state register
reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    // Default outputs
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;

    // Next state logic
    case (state)
        IDLE: begin
            if (in == 1'b1) begin
                next_state = DISC;
            end
            else begin
                next_state = IDLE;
            end
        end
        DISC: begin
            if (in == 1'b1) begin
                next_state = FLAG;
                disc = 1'b1;
            end
            else begin
                next_state = IDLE;
            end
        end
        FLAG: begin
            if (in == 1'b1) begin
                next_state = ERR;
                flag = 1'b1;
            end
            else begin
                next_state = IDLE;
            end
        end
        ERR: begin
            if (in == 1'b1) begin
                next_state = ERR;
                err = 1'b1;
            end
            else begin
                next_state = IDLE;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
