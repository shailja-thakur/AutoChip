module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

reg [2:0] state, next_state;
parameter [2:0] IDLE = 3'b000, 
                WAIT1 = 3'b001,
                WAIT2 = 3'b010,
                WAIT3 = 3'b011,
                WAIT4 = 3'b100,
                WAIT5 = 3'b101,
                WAIT6 = 3'b110,
                ERROR = 3'b111;

// State transition logic
always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    next_state = state;
    case (state)
        IDLE: begin
            if (in == 1'b1) begin
                next_state = WAIT1;
            end
        end
        WAIT1: begin
            if (in == 1'b1) begin
                next_state = WAIT2;
            end else begin
                next_state = IDLE;
            end
        end
        WAIT2: begin
            if (in == 1'b1) begin
                next_state = WAIT3;
            end else begin
                next_state = IDLE;
            end
        end
        WAIT3: begin
            if (in == 1'b1) begin
                next_state = WAIT4;
            end else begin
                next_state = IDLE;
            end
        end
        WAIT4: begin
            if (in == 1'b1) begin
                next_state = WAIT5;
            end else begin
                next_state = IDLE;
            end
        end
        WAIT5: begin
            if (in == 1'b1) begin
                next_state = WAIT6;
            end else begin
                next_state = IDLE;
            end
        end
        WAIT6: begin
            if (in == 1'b1) begin
                next_state = ERROR;
            end else begin
                next_state = IDLE;
            end
        end
        ERROR: begin
            next_state = IDLE;
        end
    endcase
end

// Output logic
always @(*) begin
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;
    case (state)
        WAIT5: begin
            disc = 1'b1;
        end
        WAIT6: begin
            flag = 1'b1;
        end
        ERROR: begin
            err = 1'b1;
        end
    endcase
end

endmodule
