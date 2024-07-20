module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    reg [1:0] state, next_state;
    reg [2:0] count;

    // State encoding
    localparam IDLE = 2'b00,
               SHIFT = 2'b01,
               DONE = 2'b10;

    // State transition
    always @(posedge clk) begin
        if (reset)
            state <= SHIFT;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: if (reset) next_state = SHIFT;
                  else next_state = IDLE;

            SHIFT: if (count == 3) next_state = DONE;
                   else next_state = SHIFT;

            DONE: next_state = DONE;

            default: next_state = IDLE;
        endcase
    end

    // Output logic and counter
    always @(posedge clk) begin
        if (reset) begin
            shift_ena <= 1;
            count <= 0;
        end else if (state == SHIFT) begin
            shift_ena <= 1;
            count <= count + 1;
            if (count == 3) begin
                shift_ena <= 0;
            end
        end else if (state == DONE) begin
            shift_ena <= 0;
        end else begin
            shift_ena <= 0;
        end
    end

endmodule
