module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // State declaration
    typedef enum reg [3:0] {
        S_IDLE        = 4'b0000,
        S_ONE_0       = 4'b0001,
        S_ONE_1       = 4'b0010,
        S_TWO_1       = 4'b0011,
        S_THREE_1     = 4'b0100,
        S_FOUR_1      = 4'b0101,
        S_FIVE_1      = 4'b0110,
        S_SIX_1       = 4'b0111,
        S_FLAG        = 4'b1000,
        S_ERROR       = 4'b1001,
        S_DISCARD     = 4'b1010
    } state_t;
    
    // State registers
    state_t state, next_state;
    
    // Next state logic
    always @(*) begin
        case(state)
            S_IDLE: begin
                if (in == 1'b0) next_state = S_ONE_0;
                else next_state = S_IDLE;
            end
            S_ONE_0: begin
                if (in == 1'b1) next_state = S_ONE_1;
                else next_state = S_ONE_0;
            end
            S_ONE_1: begin
                if (in == 1'b1) next_state = S_TWO_1;
                else next_state = S_ONE_0;
            end
            S_TWO_1: begin
                if (in == 1'b1) next_state = S_THREE_1;
                else next_state = S_ONE_0;
            end
            S_THREE_1: begin
                if (in == 1'b1) next_state = S_FOUR_1;
                else next_state = S_ONE_0;
            end
            S_FOUR_1: begin
                if (in == 1'b1) next_state = S_FIVE_1;
                else next_state = S_ONE_0;
            end
            S_FIVE_1: begin
                if (in == 1'b1) next_state = S_SIX_1;
                else next_state = S_DISCARD;
            end
            S_SIX_1: begin
                if (in == 1'b1) next_state = S_ERROR;
                else next_state = S_FLAG;
            end
            S_FLAG: begin
                next_state = (in == 1'b0) ? S_ONE_0 : S_IDLE;
            end
            S_ERROR: begin
                next_state = S_IDLE;
            end
            S_DISCARD: begin
                next_state = S_IDLE;
            end
            default: begin
                next_state = S_IDLE;
            end
        endcase
    end
    
    // State transition logic
    always @(posedge clk) begin
        if (reset) state <= S_IDLE;
        else state <= next_state;
    end
    
    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
        end
        else begin
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
            case(state)
                S_FLAG: flag <= 1'b1;
                S_ERROR: err <= 1'b1;
                S_DISCARD: disc <= 1'b1;
            endcase
        end
    end
endmodule
