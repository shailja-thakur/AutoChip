module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    reg [2:0] state, next_state;

    // State encoding
    localparam S_IDLE  = 3'b000;
    localparam S_SHIFT3 = 3'b001;
    localparam S_SHIFT2 = 3'b010;
    localparam S_SHIFT1 = 3'b011;
    localparam S_SHIFT0 = 3'b100;

    // State transition logic
    always @(posedge clk) begin
        if (reset) 
            state <= S_IDLE;
        else 
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case(state)
            S_IDLE:   next_state = reset ? S_SHIFT3 : S_IDLE;
            S_SHIFT3: next_state = S_SHIFT2;
            S_SHIFT2: next_state = S_SHIFT1;
            S_SHIFT1: next_state = S_SHIFT0;
            S_SHIFT0: next_state = S_IDLE;
            default:  next_state = S_IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            shift_ena <= 1;
        else begin
            case(state)
                S_IDLE:   shift_ena <= 0;
                S_SHIFT3: shift_ena <= 1;
                S_SHIFT2: shift_ena <= 1;
                S_SHIFT1: shift_ena <= 1;
                S_SHIFT0: shift_ena <= 1;
                default:  shift_ena <= 0;
            endcase
        end
    end

endmodule
