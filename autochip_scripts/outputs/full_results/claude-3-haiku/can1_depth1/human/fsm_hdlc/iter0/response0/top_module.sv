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
parameter ERROR = 3'b011;

reg [2:0] state, next_state;
reg [2:0] count;

// State transition logic
always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        count <= 0;
        disc <= 0;
        flag <= 0;
        err <= 0;
    end else begin
        state <= next_state;
        case (state)
            IDLE: begin
                if (in) begin
                    count <= 1;
                end else begin
                    count <= 0;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            DISC: begin
                count <= 0;
                disc <= 1;
                flag <= 0;
                err <= 0;
            end
            FLAG: begin
                count <= 0;
                disc <= 0;
                flag <= 1;
                err <= 0;
            end
            ERROR: begin
                count <= 0;
                disc <= 0;
                flag <= 0;
                err <= 1;
            end
        endcase
    end
end

// Next state logic
always @(*) begin
    case (state)
        IDLE: begin
            if (in) begin
                if (count == 5) begin
                    next_state = DISC;
                end else begin
                    next_state = IDLE;
                end
            end else begin
                next_state = IDLE;
            end
        end
        DISC: begin
            next_state = IDLE;
        end
        FLAG: begin
            next_state = IDLE;
        end
        ERROR: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
