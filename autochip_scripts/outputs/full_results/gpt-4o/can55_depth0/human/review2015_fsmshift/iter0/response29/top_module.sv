module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] count;
    reg [1:0] state, next_state;

    localparam IDLE = 2'b00,
               ACTIVE = 2'b01,
               DONE = 2'b10;

    always @(posedge clk) begin
        if (reset) begin
            state <= ACTIVE;
            count <= 0;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case(state)
            IDLE: next_state = IDLE;
            ACTIVE: next_state = (count == 4) ? DONE : ACTIVE;
            DONE: next_state = DONE;
            default: next_state = IDLE;
        endcase
    end

    always @(posedge clk) begin
        if (state == ACTIVE) begin
            count <= count + 1;
        end else if (state == IDLE || state == DONE) begin
            count <= 0;
        end
    end

    always @(posedge clk) begin
        if (state == ACTIVE && count < 4) begin
            shift_ena <= 1;
        end else begin
            shift_ena <= 0;
        end
    end

endmodule
