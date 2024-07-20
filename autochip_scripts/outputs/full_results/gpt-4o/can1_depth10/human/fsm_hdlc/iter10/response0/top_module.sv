module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // State encoding
    localparam IDLE   = 4'd0;
    localparam ONE    = 4'd1;
    localparam TWO    = 4'd2;
    localparam THREE  = 4'd3;
    localparam FOUR   = 4'd4;
    localparam FIVE   = 4'd5;
    localparam SIX    = 4'd6;
    localparam SEVEN  = 4'd7;
    localparam ERROR  = 4'd8;

    reg [3:0] state, next_state;

    // Sequential logic: state transition and output registers
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic: next state logic
    always @(*) begin
        case (state)
            IDLE: 
                next_state = in ? ONE : IDLE;
            ONE: 
                next_state = in ? TWO : IDLE;
            TWO: 
                next_state = in ? THREE : IDLE;
            THREE: 
                next_state = in ? FOUR : IDLE;
            FOUR: 
                next_state = in ? FIVE : IDLE;
            FIVE: 
                next_state = in ? SIX : IDLE;
            SIX: 
                next_state = in ? SEVEN : IDLE; // Bit requires discard, go back to IDLE if in is 0
            SEVEN: 
                next_state = in ? ERROR : IDLE; // Move to error state if 7 consecutive 1s, else flag detected, go back to IDLE
            ERROR: 
                next_state = !in ? IDLE : ERROR; // Exit error state only if we get a 0
            default: 
                next_state = IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            disc <= 0;
            flag <= 0;
            err <= 0;
        end else begin
            disc <= 0; // Default value
            flag <= 0; // Default value
            err <= 0;  // Default value
            case (next_state)
                SIX: if (!in) disc <= 1;
                SEVEN: if (!in) flag <= 1;
                ERROR: err <= 1;
            endcase
        end
    end
endmodule
