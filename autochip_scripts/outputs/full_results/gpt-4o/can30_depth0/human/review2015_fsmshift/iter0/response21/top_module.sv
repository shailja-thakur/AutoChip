module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [1:0] state, next_state;
    reg [2:0] count;

    // State encoding
    localparam IDLE = 2'b00;
    localparam SHIFT_PERIOD = 2'b01;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= SHIFT_PERIOD;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (reset) begin
                    next_state = SHIFT_PERIOD;
                end else begin
                    next_state = IDLE;
                end
            end
            SHIFT_PERIOD: begin
                if (count == 3'b100) begin
                    next_state = IDLE;
                end else begin
                    next_state = SHIFT_PERIOD;
                end
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic and count logic
    always @(posedge clk) begin
        if (reset) begin
            count <= 3'b000;
            shift_ena <= 1'b1;
        end else begin
            if (state == SHIFT_PERIOD) begin
                if (count == 3'b100) begin
                    shift_ena <= 1'b0;
                end else begin
                    shift_ena <= 1'b1;
                    count <= count + 1;
                end
            end else begin
                shift_ena <= 1'b0;
            end
        end
    end

endmodule
