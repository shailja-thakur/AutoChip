module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define the states using an enumeration
    typedef enum logic [1:0] {
        STATE_A,
        STATE_B,
        STATE_C,
        STATE_D
    } state_t;

    // Declare necessary signals
    reg [1:0] state;  // current state
    reg [1:0] next_state;  // next state

    // Combinational logic for state transitions and output generation
    always @(*) begin
        case (state)
            STATE_A: begin
                if (in == 1'b0) begin
                    next_state = STATE_A;
                    out = 1'b0;
                end
                else begin
                    next_state = STATE_B;
                    out = 1'b0;
                end
            end

            STATE_B: begin
                if (in == 1'b0) begin
                    next_state = STATE_C;
                    out = 1'b0;
                end
                else begin
                    next_state = STATE_B;
                    out = 1'b0;
                end
            end

            STATE_C: begin
                if (in == 1'b0) begin
                    next_state = STATE_A;
                    out = 1'b0;
                end
                else begin
                    next_state = STATE_D;
                    out = 1'b0;
                end
            end

            STATE_D: begin
                if (in == 1'b0) begin
                    next_state = STATE_C;
                    out = 1'b1;
                end
                else begin
                    next_state = STATE_B;
                    out = 1'b1;
                end
            end
        endcase
    end

    // Sequential logic for state updates
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= STATE_A;
        end 
        else begin
            state <= next_state;
        end
    end

endmodule
