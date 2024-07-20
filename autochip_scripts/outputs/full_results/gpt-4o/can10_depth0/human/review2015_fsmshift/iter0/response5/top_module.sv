module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] state, next_state;
    reg [2:0] count;

    localparam IDLE = 3'b000,
               SHIFT1 = 3'b001,
               SHIFT2 = 3'b010,
               SHIFT3 = 3'b011,
               SHIFT4 = 3'b100,

               DONE = 3'b101;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            count <= 3'd0;
        end
        else begin
            state <= next_state;
            if (shift_ena)
                count <= count + 1'b1;
            else
                count <= 3'd0;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (reset)
                    next_state = SHIFT1;
                else
                    next_state = IDLE;
            end

            SHIFT1: next_state = SHIFT2;
            SHIFT2: next_state = SHIFT3;
            SHIFT3: next_state = SHIFT4;
            SHIFT4: next_state = DONE;
            DONE:  next_state = DONE;

            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            shift_ena <= 1'b1;
        else if (state == DONE)
            shift_ena <= 1'b0;
        else if (reset == 1'b0 && (state == SHIFT1 || state == SHIFT2 || state == SHIFT3 || state == SHIFT4))
            shift_ena <= 1'b1;
        else if (reset == 1'b0 && state == DONE)
            shift_ena <= 1'b0;
        else
            shift_ena <= 1'b0; // This is fallback, should not happen really.
    end

endmodule
