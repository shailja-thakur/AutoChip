module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] state, next_state;
    reg [2:0] counter;

    // State encoding
    localparam IDLE = 3'b000;
    localparam SHIFT1 = 3'b001;
    localparam SHIFT2 = 3'b010;
    localparam SHIFT3 = 3'b011;
    localparam SHIFT4 = 3'b100;

    // State transition logic
    always @(*) begin
        case (state)
            IDLE: next_state = reset ? SHIFT1 : IDLE;
            SHIFT1: next_state = SHIFT2;
            SHIFT2: next_state = SHIFT3;
            SHIFT3: next_state = SHIFT4;
            SHIFT4: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Sequential logic for state updating
    always @(posedge clk) begin
        if (reset)
            state <= SHIFT1;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            counter <= 3'b000;
            shift_ena <= 1;
        end else if (state == SHIFT1 || state == SHIFT2 || state == SHIFT3 || state == SHIFT4) begin
            counter <= counter + 1;
            shift_ena <= 1;
        end else begin
            shift_ena <= 0;
        end
    end

endmodule
