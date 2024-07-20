module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // State encoding
    typedef enum reg [2:0] {
        S_IDLE = 3'b000,
        S_0 = 3'b001,
        S_01 = 3'b010,
        S_011 = 3'b011,
        S_0111 = 3'b100,
        S_01111 = 3'b101,
        S_011111 = 3'b110,
        S_0111111 = 3'b111
    } state_t;

    state_t current_state, next_state;

    // State transition
    always @(posedge clk) begin
        if (reset)
            current_state <= S_IDLE;
        else
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case(current_state)
            S_IDLE: next_state = in ? S_IDLE : S_0;
            S_0: next_state = in ? S_01 : S_0;
            S_01: next_state = in ? S_011 : S_0;
            S_011: next_state = in ? S_0111 : S_0;
            S_0111: next_state = in ? S_01111 : S_0;
            S_01111: next_state = in ? S_011111 : S_0;
            S_011111: next_state = in ? S_0111111 : S_0;
            S_0111111: next_state = in ? S_0111111 : S_IDLE;
            default: next_state = S_IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            disc <= 0;
            flag <= 0;
            err <= 0;
        end else begin
            disc <= 0;
            flag <= 0;
            err <= 0;
            case(current_state)
                S_011111: 
                    if (in) 
                        disc <= 1;   // 0111110 detected: discard bit
                S_011111: 
                    if (!in) 
                        flag <= 1;   // 01111110 detected: flag frame
                S_0111111: 
                    if (in) 
                        err <= 1;   // 01111111 or more detected: error
            endcase
        end
    end

endmodule
