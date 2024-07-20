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
                 DETECT_1 = 3'b001,
                 DETECT_2 = 3'b010,
                 DETECT_3 = 3'b011,
                 DETECT_4 = 3'b100,
                 DETECT_5 = 3'b101,
                 DETECT_6 = 3'b110,
                 DETECT_7 = 3'b111;

reg [2:0] state, next_state;

// Implement the state transition logic
always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (in == 1'b1) begin
                next_state = DETECT_1;
            end
            else begin
                next_state = IDLE;
            end
        end
        DETECT_1: begin
            if (in == 1'b1) begin
                next_state = DETECT_2;
            end
            else begin
                next_state = IDLE;
            end
        end
        DETECT_2: begin
            if (in == 1'b1) begin
                next_state = DETECT_3;
            end
            else begin
                next_state = IDLE;
            end
        end
        DETECT_3: begin
            if (in == 1'b1) begin
                next_state = DETECT_4;
            end
            else begin
                next_state = IDLE;
            end
        end
        DETECT_4: begin
            if (in == 1'b1) begin
                next_state = DETECT_5;
            end
            else begin
                next_state = IDLE;
            end
        end
        DETECT_5: begin
            if (in == 1'b1) begin
                next_state = DETECT_6;
            end
            else begin
                next_state = IDLE;
            end
        end
        DETECT_6: begin
            if (in == 1'b0) begin
                next_state = IDLE;
                disc = 1'b1;
            end
            else if (in == 1'b1) begin
                next_state = DETECT_7;
                flag = 1'b1;
            end
            else begin
                next_state = IDLE;
            end
        end
        DETECT_7: begin
            if (in == 1'b1) begin
                next_state = DETECT_7;
                err = 1'b1;
            end
            else begin
                next_state = IDLE;
            end
        end
    endcase
end

// Assign the output signals
always @(posedge clk) begin
    if (reset) begin
        disc <= 1'b0;
        flag <= 1'b0;
        err <= 1'b0;
    end
    else begin
        disc <= (state == DETECT_6 && in == 1'b0) ? 1'b1 : 1'b0;
        flag <= (state == DETECT_6 && in == 1'b1) ? 1'b1 : 1'b0;
        err <= (state == DETECT_7 && in == 1'b1) ? 1'b1 : 1'b0;
    end
end

endmodule
