module top_module(
	input clk,
	input reset,
	output reg shift_ena);

    reg [2:0] state, next_state;
    reg [2:0] counter;

    // State definitions
    localparam IDLE  = 3'b000;
    localparam SHIFT = 3'b001;

    // State transition and counter logic
    always @(posedge clk) begin
        if (reset) begin
            state <= SHIFT;
            counter <= 3'd4;
        end
        else begin
            state <= next_state;
            if (state == SHIFT && counter != 0) begin
                counter <= counter - 1;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: next_state = IDLE;
            SHIFT: begin
                if(counter == 0)
                    next_state = IDLE;
                else
                    next_state = SHIFT;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(*) begin
        if (state == SHIFT)
            shift_ena = 1;
        else
            shift_ena = 0;
    end
endmodule
