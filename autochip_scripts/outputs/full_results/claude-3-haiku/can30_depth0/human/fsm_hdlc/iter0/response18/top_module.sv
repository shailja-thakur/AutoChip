module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

reg [2:0] state, next_state;

// State encoding
localparam IDLE = 3'd0;
localparam FOUND_1 = 3'd1;
localparam FOUND_2 = 3'd2;
localparam FOUND_3 = 3'd3;
localparam FOUND_4 = 3'd4;
localparam FOUND_5 = 3'd5;
localparam FOUND_6 = 3'd6;
localparam ERROR = 3'd7;

// State update logic
always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

// Next state and output logic
always @(*) begin
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;

    next_state = state;

    case (state)
        IDLE: begin
            if (in == 1'b1) begin
                next_state = FOUND_1;
            end
        end
        FOUND_1: begin
            if (in == 1'b1) begin
                next_state = FOUND_2;
            end
            else begin
                next_state = IDLE;
            end
        end
        FOUND_2: begin
            if (in == 1'b1) begin
                next_state = FOUND_3;
            end
            else begin
                next_state = IDLE;
            end
        end
        FOUND_3: begin
            if (in == 1'b1) begin
                next_state = FOUND_4;
            end
            else begin
                next_state = IDLE;
            end
        end
        FOUND_4: begin
            if (in == 1'b1) begin
                next_state = FOUND_5;
            end
            else begin
                next_state = IDLE;
            end
        end
        FOUND_5: begin
            if (in == 1'b1) begin
                next_state = FOUND_6;
            end
            else begin
                next_state = IDLE;
            end
        end
        FOUND_6: begin
            if (in == 1'b1) begin
                next_state = ERROR;
                err = 1'b1;
            end
            else begin
                next_state = IDLE;
                disc = 1'b1;
                flag = 1'b1;
            end
        end
        ERROR: begin
            if (in == 1'b0) begin
                next_state = IDLE;
            end
            else begin
                next_state = ERROR;
                err = 1'b1;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
