module top_module (
    input clk,
    input reset,
    output reg shift_ena
);
    reg [2:0] state, next_state;

    // State definition
    localparam IDLE    = 3'b000;
    localparam SHIFT_1 = 3'b001;
    localparam SHIFT_2 = 3'b010;
    localparam SHIFT_3 = 3'b011;
    localparam SHIFT_4 = 3'b100;
    localparam DONE    = 3'b101;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= SHIFT_1;
        end
        else begin
            state <= next_state;
        end
    end
    
    // Next state logic
    always @(*) begin
        case(state)
            IDLE: next_state = IDLE;
            SHIFT_1: next_state = SHIFT_2;
            SHIFT_2: next_state = SHIFT_3;
            SHIFT_3: next_state = SHIFT_4;
            SHIFT_4: next_state = DONE;
            DONE: next_state = DONE;
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            shift_ena <= 1'b1;
        end 
        else if (state == SHIFT_1 || state == SHIFT_2 || state == SHIFT_3 || state == SHIFT_4) begin
            shift_ena <= 1'b1;
        end 
        else if (state == DONE) begin
            shift_ena <= 1'b0;
        end
        else begin
            shift_ena <= 1'b0;
        end
    end

endmodule
