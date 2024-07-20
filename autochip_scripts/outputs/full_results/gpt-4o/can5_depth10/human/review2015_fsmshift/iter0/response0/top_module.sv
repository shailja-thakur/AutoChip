module top_module(
    input clk,
    input reset,
    output reg shift_ena
);
    
    reg [2:0] state, next_state;

    // State encoding
    localparam IDLE  = 3'b000;
    localparam SHIFT1 = 3'b001;
    localparam SHIFT2 = 3'b010;
    localparam SHIFT3 = 3'b011;
    localparam SHIFT4 = 3'b100;
    localparam DONE  = 3'b101;

    // State transition
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic and output logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (reset) begin
                    next_state = SHIFT1;
                    shift_ena = 1;
                end else begin
                    next_state = IDLE;
                    shift_ena = 0;
                end
            end
            SHIFT1: begin
                next_state = SHIFT2;
                shift_ena = 1;
            end
            SHIFT2: begin
                next_state = SHIFT3;
                shift_ena = 1;
            end
            SHIFT3: begin
                next_state = SHIFT4;
                shift_ena = 1;
            end
            SHIFT4: begin
                next_state = DONE;
                shift_ena = 1;
            end
            DONE: begin
                next_state = DONE;
                shift_ena = 0;
            end
            default: begin
                next_state = IDLE;
                shift_ena = 0;
            end
        endcase
    end

endmodule
