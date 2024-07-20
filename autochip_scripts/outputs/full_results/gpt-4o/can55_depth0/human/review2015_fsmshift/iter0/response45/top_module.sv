module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    reg [1:0] state, next_state;
    reg [2:0] counter;

    // State encoding
    localparam IDLE = 2'b00;
    localparam SHIFT = 2'b01;
    localparam DONE = 2'b10;

    // State transition logic
    always @(*) begin
        case (state)
            IDLE: next_state = reset ? SHIFT : IDLE;
            SHIFT: next_state = (counter == 3'b100) ? DONE : SHIFT;
            DONE: next_state = reset ? SHIFT : DONE;
            default: next_state = IDLE;
        endcase
    end

    // Counter logic
    always @(posedge clk) begin
        if (state == SHIFT) begin
            if (counter < 3'b100) begin
                counter <= counter + 1;
            end else begin
                counter <= 3'b000; // Reset counter when done
            end
        end else if (state == IDLE) begin
            counter <= 3'b000; // Reset counter to 0 in IDLE state
        end
    end

    // State flip-flops
    always @(posedge clk) begin
        if (reset) begin
            state <= SHIFT;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            shift_ena <= 1;
        end else if (state == SHIFT) begin
            shift_ena <= (counter < 3'b100);
        end else begin
            shift_ena <= 0;
        end
    end

endmodule
