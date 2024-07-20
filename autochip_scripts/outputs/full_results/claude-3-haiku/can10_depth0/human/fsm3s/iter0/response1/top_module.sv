module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define the states
    localparam STATE_A = 2'b00;
    localparam STATE_B = 2'b01;
    localparam STATE_C = 2'b10;
    localparam STATE_D = 2'b11;

    // Register to hold the current state
    reg [1:0] current_state, next_state;

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (in == 1'b0) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
            end
            STATE_B: begin
                if (in == 1'b0) begin
                    next_state = STATE_C;
                end else begin
                    next_state = STATE_B;
                end
            end
            STATE_C: begin
                if (in == 1'b0) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_D;
                end
            end
            STATE_D: begin
                if (in == 1'b0) begin
                    next_state = STATE_C;
                end else begin
                    next_state = STATE_B;
                end
            end
            default: begin
                next_state = STATE_A;
            end
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            STATE_D: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

endmodule
