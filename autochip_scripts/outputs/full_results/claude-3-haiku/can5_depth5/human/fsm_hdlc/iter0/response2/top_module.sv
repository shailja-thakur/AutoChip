module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

reg [2:0] state, next_state;
parameter IDLE = 3'b000, DETECT_1 = 3'b001, DETECT_2 = 3'b010, DETECT_3 = 3'b011, DETECT_4 = 3'b100, DETECT_5 = 3'b101, DETECT_6 = 3'b110, DETECT_7 = 3'b111;

// State update logic
always @(posedge clk) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

// Next state and output logic
always @(*) begin
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;
    case (state)
        IDLE: begin
            if (in == 1'b1)
                next_state = DETECT_1;
            else
                next_state = IDLE;
        end
        DETECT_1: begin
            if (in == 1'b1)
                next_state = DETECT_2;
            else
                next_state = IDLE;
        end
        DETECT_2: begin
            if (in == 1'b1)
                next_state = DETECT_3;
            else
                next_state = IDLE;
        end
        DETECT_3: begin
            if (in == 1'b1)
                next_state = DETECT_4;
            else
                next_state = IDLE;
        end
        DETECT_4: begin
            if (in == 1'b1)
                next_state = DETECT_5;
            else
                next_state = IDLE;
        end
        DETECT_5: begin
            if (in == 1'b1)
                next_state = DETECT_6;
            else begin
                disc = 1'b1;
                next_state = IDLE;
            end
        end
        DETECT_6: begin
            if (in == 1'b1) begin
                flag = 1'b1;
                next_state = IDLE;
            end
            else begin
                next_state = IDLE;
            end
        end
        DETECT_7: begin
            if (in == 1'b1)
                err = 1'b1;
            next_state = IDLE;
        end
        default: next_state = IDLE;
    endcase
end

endmodule
