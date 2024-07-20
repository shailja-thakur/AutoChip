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

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (in == 1'b0) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
                out = 1'b0;
            end
            STATE_B: begin
                if (in == 1'b0) begin
                    next_state = STATE_C;
                end else begin
                    next_state = STATE_B;
                end
                out = 1'b0;
            end
            STATE_C: begin
                if (in == 1'b0) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_D;
                end
                out = 1'b0;
            end
            STATE_D: begin
                if (in == 1'b0) begin
                    next_state = STATE_C;
                end else begin
                    next_state = STATE_B;
                end
                out = 1'b1;
            end
            default: begin
                next_state = STATE_A;
                out = 1'b0;
            end
        endcase
    end

    // Update the current state on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

endmodule
