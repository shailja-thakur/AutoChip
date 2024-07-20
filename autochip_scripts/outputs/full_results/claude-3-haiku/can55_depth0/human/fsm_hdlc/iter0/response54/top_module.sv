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

// Register to store the current state
reg [2:0] state, next_state;

// Combinational logic to determine the next state
always @(*) begin
    case (state)
        IDLE: begin
            if (in == 1'b1) begin
                next_state = DISC;
            end else begin
                next_state = IDLE;
            end
        end
        DISC: begin
            if (in == 1'b1) begin
                next_state = FLAG;
            end else begin
                next_state = IDLE;
            end
        end
        FLAG: begin
            if (in == 1'b1) begin
                next_state = ERR;
            end else begin
                next_state = IDLE;
            end
        end
        ERR: begin
            if (in == 1'b1) begin
                next_state = ERR;
            end else begin
                next_state = IDLE;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

// Sequential logic to update the current state
always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

// Output logic
always @(*) begin
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;
    case (state)
        DISC: begin
            disc = 1'b1;
        end
        FLAG: begin
            flag = 1'b1;
        end
        ERR: begin
            err = 1'b1;
        end
        default: begin
            // do nothing
        end
    endcase
end

endmodule
